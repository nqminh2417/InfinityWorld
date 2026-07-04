import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

typedef DecisionWheelPickIndex = int Function(int optionCount);

int _systemPickIndex(int optionCount) => math.Random().nextInt(optionCount);

class DecisionWheelScreen extends StatefulWidget {
  final DecisionWheelPickIndex pickIndex;

  const DecisionWheelScreen({super.key, this.pickIndex = _systemPickIndex});

  @override
  State<DecisionWheelScreen> createState() => _DecisionWheelScreenState();
}

class _DecisionWheelScreenState extends State<DecisionWheelScreen> {
  final _optionsController = TextEditingController();

  String? _selectedOption;
  int? _selectedIndex;
  String? _errorText;

  @override
  void dispose() {
    _optionsController.dispose();
    super.dispose();
  }

  void _spin() {
    final options = _parseOptions(_optionsController.text);

    if (options.length < 2) {
      setState(() {
        _selectedOption = null;
        _selectedIndex = null;
        _errorText = 'Add at least two options.';
      });
      return;
    }

    final rawIndex = widget.pickIndex(options.length);
    final selectedIndex = rawIndex.clamp(0, options.length - 1).toInt();

    setState(() {
      _selectedOption = options[selectedIndex];
      _selectedIndex = selectedIndex;
      _errorText = null;
    });
  }

  List<String> _parseOptions(String input) {
    return input
        .split('\n')
        .map((option) => option.trim())
        .where((option) => option.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final options = _parseOptions(_optionsController.text);
    final selectedIndex =
        _selectedIndex != null && _selectedIndex! < options.length
            ? _selectedIndex
            : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Decision Wheel')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Spin a decision',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space8),
              Text(
                'Add one option per line, then spin a local decision wheel.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: IwColors.textSecondary(brightness),
                ),
              ),
              const SizedBox(height: IwSpacing.space16),
              IwCard(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: DecisionWheelFace(
                        options: options,
                        selectedIndex: selectedIndex,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: IwSpacing.space16),
              TextField(
                controller: _optionsController,
                minLines: 5,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  errorText: _errorText,
                  hintText: 'Movie\nPizza\nStudy',
                  labelText: 'Options',
                ),
                onChanged: (_) {
                  setState(() {
                    _selectedOption = null;
                    _selectedIndex = null;
                    _errorText = null;
                  });
                },
              ),
              const SizedBox(height: IwSpacing.space16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _spin,
                  icon: const Icon(Icons.casino_rounded),
                  label: const Text('Spin'),
                ),
              ),
              if (_selectedOption != null) ...[
                const SizedBox(height: IwSpacing.space16),
                IwCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected option',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: IwColors.textSecondary(brightness),
                        ),
                      ),
                      const SizedBox(height: IwSpacing.space6),
                      Text(
                        _selectedOption!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class DecisionWheelFace extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;

  const DecisionWheelFace({
    super.key,
    required this.options,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomPaint(
      painter: DecisionWheelPainter(
        options: options,
        selectedIndex: selectedIndex,
        brightness: Theme.of(context).brightness,
        tertiaryColor: colorScheme.tertiary,
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class DecisionWheelPainter extends CustomPainter {
  final List<String> options;
  final int? selectedIndex;
  final Brightness brightness;
  final Color tertiaryColor;
  final TextStyle? textStyle;

  const DecisionWheelPainter({
    required this.options,
    required this.selectedIndex,
    required this.brightness,
    required this.tertiaryColor,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 14;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final borderPaint =
        Paint()
          ..color = IwColors.border(brightness)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
    final fillPaint = Paint()..style = PaintingStyle.fill;

    if (options.isEmpty) {
      fillPaint.color = IwColors.surface2(brightness);
      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, borderPaint);
      _paintCenteredText(
        canvas,
        'Add options',
        center,
        radius * 1.4,
        textStyle?.copyWith(color: IwColors.textSecondary(brightness)) ??
            TextStyle(color: IwColors.textSecondary(brightness)),
      );
      return;
    }

    final palette = [
      IwColors.primary,
      IwColors.secondary(brightness),
      IwColors.primaryBright,
      tertiaryColor,
    ];
    final segmentAngle = math.pi * 2 / options.length;
    const startAngle = -math.pi / 2;

    for (var index = 0; index < options.length; index += 1) {
      final isSelected = selectedIndex == index;
      final hasSelection = selectedIndex != null;
      fillPaint.color = palette[index % palette.length].withValues(
        alpha: hasSelection && !isSelected ? 0.28 : 0.88,
      );
      canvas.drawArc(
        rect,
        startAngle + segmentAngle * index,
        segmentAngle,
        true,
        fillPaint,
      );
    }

    final dividerPaint =
        Paint()
          ..color = IwColors.surface1(brightness)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    for (var index = 0; index < options.length; index += 1) {
      final angle = startAngle + segmentAngle * index;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle), math.sin(angle)) * radius,
        dividerPaint,
      );
    }

    canvas.drawCircle(center, radius, borderPaint);
    _paintSegmentNumbers(canvas, center, radius, segmentAngle, startAngle);
    _paintPointer(canvas, center, radius);

    final pivotPaint =
        Paint()
          ..color = IwColors.surface1(brightness)
          ..style = PaintingStyle.fill;
    final pivotBorderPaint =
        Paint()
          ..color =
              brightness == Brightness.dark
                  ? IwColors.darkTextPrimary
                  : IwColors.lightTextPrimary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
    canvas.drawCircle(center, math.max(5, radius * 0.05), pivotPaint);
    canvas.drawCircle(center, math.max(5, radius * 0.05), pivotBorderPaint);
  }

  void _paintSegmentNumbers(
    Canvas canvas,
    Offset center,
    double radius,
    double segmentAngle,
    double startAngle,
  ) {
    final labelStyle =
        textStyle?.copyWith(color: IwColors.textPrimary(brightness)) ??
        TextStyle(color: IwColors.textPrimary(brightness));

    for (var index = 0; index < options.length; index += 1) {
      final angle = startAngle + segmentAngle * (index + 0.5);
      final offset =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.68);
      _paintCenteredText(canvas, '${index + 1}', offset, 32, labelStyle);
    }
  }

  void _paintPointer(Canvas canvas, Offset center, double radius) {
    final top = center.dy - radius + 6;
    final pointerPaint =
        Paint()
          ..color = IwColors.textPrimary(brightness)
          ..style = PaintingStyle.fill;
    final pointerPath =
        Path()
          ..moveTo(center.dx, top + 18)
          ..lineTo(center.dx - 10, top)
          ..lineTo(center.dx + 10, top)
          ..close();

    canvas.drawPath(pointerPath, pointerPaint);
  }

  void _paintCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    double maxWidth,
    TextStyle style,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      ellipsis: '...',
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant DecisionWheelPainter oldDelegate) {
    return oldDelegate.options.join('\n') != options.join('\n') ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.brightness != brightness ||
        oldDelegate.tertiaryColor != tertiaryColor ||
        oldDelegate.textStyle != textStyle;
  }
}
