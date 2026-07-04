import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

typedef RandomPickerPickIndex = int Function(int optionCount);

int _systemPickIndex(int optionCount) => math.Random().nextInt(optionCount);

class RandomPickerScreen extends StatefulWidget {
  final RandomPickerPickIndex pickIndex;

  const RandomPickerScreen({super.key, this.pickIndex = _systemPickIndex});

  @override
  State<RandomPickerScreen> createState() => _RandomPickerScreenState();
}

class _RandomPickerScreenState extends State<RandomPickerScreen> {
  final _optionsController = TextEditingController();

  String? _selectedOption;
  String? _errorText;

  @override
  void dispose() {
    _optionsController.dispose();
    super.dispose();
  }

  void _pickOne() {
    final options = _parseOptions(_optionsController.text);

    if (options.length < 2) {
      setState(() {
        _selectedOption = null;
        _errorText = 'Add at least two options.';
      });
      return;
    }

    final rawIndex = widget.pickIndex(options.length);
    final selectedIndex = rawIndex.clamp(0, options.length - 1).toInt();

    setState(() {
      _selectedOption = options[selectedIndex];
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

    return Scaffold(
      appBar: AppBar(title: const Text('Random Picker')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pick from a list',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space8),
              Text(
                'Add one option per line, then let InfinityWorld choose one.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: IwColors.textSecondary(brightness),
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
                  hintText: 'Pizza\nSushi\nTacos',
                  labelText: 'Options',
                ),
                onChanged: (_) {
                  if (_errorText == null) {
                    return;
                  }
                  setState(() {
                    _errorText = null;
                  });
                },
              ),
              const SizedBox(height: IwSpacing.space16),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _pickOne,
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Pick one'),
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
