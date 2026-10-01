import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/device_info/data/device_info_service.dart';
import 'package:infinity_world/features/device_info/domain/device_info_snapshot.dart';

typedef DeviceInfoLoader =
    Future<DeviceInfoSnapshot> Function(DeviceInfoDisplayMetrics display);

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key, this.loadInfo});

  final DeviceInfoLoader? loadInfo;

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  late final DeviceInfoLoader _loadInfo;
  DeviceInfoSnapshot? _snapshot;
  bool _hasLoaded = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInfo = widget.loadInfo ?? DeviceInfoService().load;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      _load();
    }
  }

  Future<void> _load() async {
    final display = DeviceInfoDisplayMetrics.fromMediaQuery(
      MediaQuery.of(context),
    );
    setState(() => _isLoading = true);

    DeviceInfoSnapshot snapshot;
    try {
      snapshot = await _loadInfo(display);
    } catch (_) {
      snapshot = DeviceInfoSnapshot.unavailable(display);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _snapshot = snapshot;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final display = DeviceInfoDisplayMetrics.fromMediaQuery(
      MediaQuery.of(context),
    );
    final snapshot = _snapshot ?? DeviceInfoSnapshot.loading(display);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info'),
        actions: [
          IconButton(
            tooltip: 'Refresh device information',
            onPressed: _isLoading ? null : _load,
            icon:
                _isLoading
                    ? const SizedBox(
                      width: IwSpacing.space20,
                      height: IwSpacing.space20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'Phone and system information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Information is read locally from this device.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            for (final section in snapshot.sections) ...[
              _DeviceInfoSectionCard(section: section),
              const SizedBox(height: IwSpacing.space12),
            ],
          ],
        ),
      ),
    );
  }
}

class _DeviceInfoSectionCard extends StatelessWidget {
  const _DeviceInfoSectionCard({required this.section});

  final DeviceInfoSection section;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return IwCard(
      child: Column(
        key: Key('device-info-section-${section.title}'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: IwSpacing.space8),
          for (var index = 0; index < section.rows.length; index++) ...[
            _DeviceInfoRow(row: section.rows[index]),
            if (index < section.rows.length - 1)
              Divider(
                height: IwSpacing.space16,
                color: IwColors.border(brightness),
              ),
          ],
        ],
      ),
    );
  }
}

class _DeviceInfoRow extends StatelessWidget {
  const _DeviceInfoRow({required this.row});

  final DeviceInfoRow row;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            row.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: IwColors.textSecondary(brightness),
            ),
          ),
        ),
        const SizedBox(width: IwSpacing.space12),
        Expanded(
          flex: 6,
          child: Text(
            row.value,
            textAlign: TextAlign.right,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
