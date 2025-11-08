import 'package:flutter/material.dart';
import 'package:infinity_world/widgets/text_field/floating_label.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})],
        title: Text('Test Screen'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          TextField(decoration: InputDecoration(hintText: 'Enter some text', labelText: 'Phone')),
          FloatingLabelTextField(controller: TextEditingController(), label: 'Username'),
          TextField(decoration: InputDecoration(hintText: 'Enter some text', labelText: 'Password')),
        ],
      ),
    );
  }
}
