import 'dart:async';

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
            Text('Digital time', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Live local and California time, updated every second.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
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
