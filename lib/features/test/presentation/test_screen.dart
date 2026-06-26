import 'package:flutter/material.dart';
import 'package:infinity_world/widgets/text_field/floating_label.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardBottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})],
        title: const Text('Test Screen'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20 + keyboardBottomInset),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter some text',
                  labelText: 'Phone',
                ),
              ),
              FloatingLabelTextField(
                controller: _usernameController,
                label: 'Username',
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter some text',
                  labelText: 'Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
