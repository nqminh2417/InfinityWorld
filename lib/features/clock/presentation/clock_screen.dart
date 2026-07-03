import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/clock/domain/clock_time_formatter.dart';

typedef ClockNow = DateTime Function();

DateTime _systemNow() => DateTime.now();

class ClockScreen extends StatefulWidget {
  final ClockNow now;
  final ClockTimeFormatter formatter;

  const ClockScreen({
    super.key,
    this.now = _systemNow,
    this.formatter = const ClockTimeFormatter(),
  });

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late DateTime _now;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _now = widget.now();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _now = widget.now();
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final formatter = widget.formatter;

    return Scaffold(
      appBar: AppBar(title: const Text('Clock')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'Analog and digital time',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Live local and California time, updated every second.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(child: AnalogClockFace(time: _now)),
            const SizedBox(height: IwSpacing.space12),
            _ClockTimeCard(
              icon: Icons.schedule_rounded,
              label: 'Device local current time',
              time: formatter.formatDeviceTime(_now),
            ),
            const SizedBox(height: IwSpacing.space12),
            _ClockTimeCard(
              icon: Icons.public_rounded,
              label: 'California current time',
              time: formatter.formatCaliforniaTime(_now),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalogClockFace extends StatelessWidget {
  final DateTime time;

  const AnalogClockFace({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Analog clock face',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: AspectRatio(
            aspectRatio: 1,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: AnalogClockPainter(
                  time: time,
                  borderColor: IwColors.border(brightness),
                  tickColor: IwColors.textSecondary(brightness),
                  numberColor: IwColors.textSecondary(brightness),
                  majorNumberColor: IwColors.textPrimary(brightness),
                  hourHandColor: IwColors.textPrimary(brightness),
                  minuteHandColor: colorScheme.primary,
                  secondHandColor: IwColors.secondary(brightness),
                  centerColor: colorScheme.primary,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  final DateTime time;
  final Color borderColor;
  final Color tickColor;
  final Color numberColor;
  final Color majorNumberColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color centerColor;

  const AnalogClockPainter({
    required this.time,
    required this.borderColor,
    required this.tickColor,
    required this.numberColor,
    required this.majorNumberColor,
    required this.hourHandColor,
    required this.minuteHandColor,
    required this.secondHandColor,
    required this.centerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shortestSide = math.min(size.width, size.height);
    if (shortestSide <= 0) {
      return;
    }

    final center = Offset(size.width / 2, size.height / 2);
    final radius = shortestSide / 2;
    final outerRadius = radius - math.max(2, radius * 0.02);

    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1, radius * 0.01);

    canvas.drawCircle(center, outerRadius, borderPaint);
    _drawTicks(canvas, center, outerRadius);
    _drawNumbers(canvas, center, outerRadius);
    _drawHands(canvas, center, outerRadius);
    _drawCenterDot(canvas, center, outerRadius);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final paint =
        Paint()
          ..color = tickColor
          ..strokeCap = StrokeCap.round;

    for (var tick = 0; tick < 60; tick += 1) {
      final isHourTick = tick % 5 == 0;
      final angle = tick * math.pi / 30 - math.pi / 2;
      final tickLength = radius * (isHourTick ? 0.085 : 0.045);
      final outerPoint = _pointOnCircle(center, angle, radius - radius * 0.02);
      final innerPoint = _pointOnCircle(center, angle, radius - tickLength);

      paint.strokeWidth = math.max(1, radius * (isHourTick ? 0.014 : 0.007));
      canvas.drawLine(innerPoint, outerPoint, paint);
    }
  }

  void _drawNumbers(Canvas canvas, Offset center, double radius) {
    for (var number = 1; number <= 12; number += 1) {
      final isMajor = number == 12 || number == 3 || number == 6 || number == 9;
      final angle = number * math.pi / 6 - math.pi / 2;
      final fontSize =
          (radius * (isMajor ? 0.18 : 0.13))
              .clamp(isMajor ? 18.0 : 13.0, isMajor ? 30.0 : 22.0)
              .toDouble();
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$number',
          style: TextStyle(
            color: isMajor ? majorNumberColor : numberColor,
            fontSize: fontSize,
            fontWeight: isMajor ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final textCenter = _pointOnCircle(center, angle, radius * 0.67);
      textPainter.paint(
        canvas,
        textCenter - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  void _drawHands(Canvas canvas, Offset center, double radius) {
    final hourAngle =
        ((time.hour % 12) + time.minute / 60 + time.second / 3600) *
            math.pi /
            6 -
        math.pi / 2;
    final minuteAngle =
        (time.minute + time.second / 60) * math.pi / 30 - math.pi / 2;
    final secondAngle = time.second * math.pi / 30 - math.pi / 2;

    _drawHand(
      canvas,
      center,
      hourAngle,
      radius * 0.43,
      math.max(3, radius * 0.04),
      hourHandColor,
    );
    _drawHand(
      canvas,
      center,
      minuteAngle,
      radius * 0.6,
      math.max(2, radius * 0.026),
      minuteHandColor,
    );
    _drawHand(
      canvas,
      center,
      secondAngle,
      radius * 0.72,
      math.max(1, radius * 0.01),
      secondHandColor,
    );
  }

  void _drawHand(
    Canvas canvas,
    Offset center,
    double angle,
    double length,
    double strokeWidth,
    Color color,
  ) {
    final paint =
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

    canvas.drawLine(center, _pointOnCircle(center, angle, length), paint);
  }

  void _drawCenterDot(Canvas canvas, Offset center, double radius) {
    final paint = Paint()..color = centerColor;
    canvas.drawCircle(center, math.max(4, radius * 0.035), paint);
  }

  Offset _pointOnCircle(Offset center, double angle, double radius) {
    return Offset(
      center.dx + math.cos(angle) * radius,
      center.dy + math.sin(angle) * radius,
    );
  }

  @override
  bool shouldRepaint(covariant AnalogClockPainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.tickColor != tickColor ||
        oldDelegate.numberColor != numberColor ||
        oldDelegate.majorNumberColor != majorNumberColor ||
        oldDelegate.hourHandColor != hourHandColor ||
        oldDelegate.minuteHandColor != minuteHandColor ||
        oldDelegate.secondHandColor != secondHandColor ||
        oldDelegate.centerColor != centerColor;
  }
}

class _ClockTimeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;

  const _ClockTimeCard({
    required this.icon,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return IwCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: IwSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: IwColors.textSecondary(brightness),
                  ),
                ),
                const SizedBox(height: IwSpacing.space6),
                Text(
                  time,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
