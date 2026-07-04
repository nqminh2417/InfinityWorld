import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/unit_converter/domain/unit_converter.dart';

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final _valueController = TextEditingController();

  UnitConverterCategory _category = UnitConverterCategory.length;
  String _fromUnitId = 'meter';
  String _toUnitId = 'kilometer';
  String? _errorText;
  String? _sourceText;
  String? _resultText;

  UnitConverterSpec get _spec => unitConverterSpecFor(_category);

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _selectCategory(UnitConverterCategory? category) {
    if (category == null) {
      return;
    }

    final units = unitConverterSpecFor(category).units;

    setState(() {
      _category = category;
      _fromUnitId = units.first.id;
      _toUnitId = units.length > 1 ? units[1].id : units.first.id;
      _errorText = null;
      _sourceText = null;
      _resultText = null;
    });
  }

  void _convert() {
    final value = double.tryParse(_valueController.text.trim());
    if (value == null || !value.isFinite) {
      setState(() {
        _errorText = 'Enter a valid number.';
        _sourceText = null;
        _resultText = null;
      });
      return;
    }

    final fromUnit = unitConverterUnitById(_category, _fromUnitId);
    final toUnit = unitConverterUnitById(_category, _toUnitId);
    final convertedValue = convertUnit(
      category: _category,
      fromUnitId: _fromUnitId,
      toUnitId: _toUnitId,
      value: value,
    );

    setState(() {
      _errorText = null;
      _sourceText = '${formatConvertedValue(value)} ${fromUnit.symbol}';
      _resultText = '${formatConvertedValue(convertedValue)} ${toUnit.symbol}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Convert units',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space8),
              Text(
                'Convert common length and weight values locally.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: IwColors.textSecondary(brightness),
                ),
              ),
              const SizedBox(height: IwSpacing.space16),
              DropdownButtonFormField<UnitConverterCategory>(
                initialValue: _category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                items: unitConverterSpecs
                    .map(
                      (spec) => DropdownMenuItem(
                        value: spec.category,
                        child: Text(spec.label),
                      ),
                    )
                    .toList(growable: false),
                onChanged: _selectCategory,
              ),
              const SizedBox(height: IwSpacing.space12),
              TextField(
                controller: _valueController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _errorText,
                  labelText: 'Value',
                ),
                onChanged: (_) {
                  if (_errorText == null) {
                    return;
                  }

                  setState(() {
                    _errorText = null;
                  });
                },
                onSubmitted: (_) => _convert(),
              ),
              const SizedBox(height: IwSpacing.space12),
              _UnitDropdown(
                label: 'From',
                value: _fromUnitId,
                units: _spec.units,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _fromUnitId = value;
                    _sourceText = null;
                    _resultText = null;
                  });
                },
              ),
              const SizedBox(height: IwSpacing.space12),
              _UnitDropdown(
                label: 'To',
                value: _toUnitId,
                units: _spec.units,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _toUnitId = value;
                    _sourceText = null;
                    _resultText = null;
                  });
                },
              ),
              const SizedBox(height: IwSpacing.space16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _convert,
                  icon: const Icon(Icons.swap_horiz_rounded),
                  label: const Text('Convert'),
                ),
              ),
              if (_resultText != null) ...[
                const SizedBox(height: IwSpacing.space16),
                IwCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _sourceText!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: IwColors.textSecondary(brightness),
                        ),
                      ),
                      const SizedBox(height: IwSpacing.space6),
                      Text(
                        _resultText!,
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

class _UnitDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<UnitDefinition> units;
  final ValueChanged<String?> onChanged;

  const _UnitDropdown({
    required this.label,
    required this.value,
    required this.units,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: ValueKey('$label-$value'),
      initialValue: value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      items: units
          .map(
            (unit) => DropdownMenuItem(
              value: unit.id,
              child: Text('${unit.label} (${unit.symbol})'),
            ),
          )
          .toList(growable: false),
      onChanged: onChanged,
    );
  }
}
