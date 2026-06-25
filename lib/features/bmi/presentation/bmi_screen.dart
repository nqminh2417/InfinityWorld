import 'package:flutter/material.dart';
import 'package:infinity_world/features/bmi/domain/bmi_calculator.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? _bmi;
  String _resultText = '';

  void _calculateBMI() {
    final heightCm = double.tryParse(_heightController.text);
    final weightKg = double.tryParse(_weightController.text);

    if (heightCm == null ||
        weightKg == null ||
        heightCm <= 0 ||
        weightKg <= 0) {
      setState(() {
        _bmi = null;
        _resultText = 'Vui lòng nhập số hợp lệ';
      });
      return;
    }

    final bmi = calculateBmi(heightCm: heightCm, weightKg: weightKg);
    final category = classifyBmi(bmi);

    setState(() {
      _bmi = bmi;
      _resultText = category.displayLabel;
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tính BMI'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Chiều cao
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Chiều cao (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Cân nặng
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Cân nặng (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Nút tính
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text('Tính BMI', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),

              // Kết quả
              if (_bmi != null)
                Column(
                  children: [
                    Text(
                      'BMI: ${_bmi!.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _resultText,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
              else if (_resultText.isNotEmpty)
                Text(_resultText, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
