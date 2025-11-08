import 'package:flutter/material.dart';

class FloatingLabelTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final bool readOnly;

  const FloatingLabelTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  State<FloatingLabelTextField> createState() => _FloatingLabelTextFieldState();
}

class _FloatingLabelTextFieldState extends State<FloatingLabelTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus || widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        // keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          // isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          floatingLabelStyle: TextStyle(color: _isFocused ? Colors.blue : Colors.grey),
          labelText: widget.label,
          // You can customize other properties of the input field here
        ),
        readOnly: widget.readOnly,
        onTapOutside: (event) {
          setState(() {
            FocusScope.of(context).requestFocus(FocusNode());
          });
        },
      ),
    );
  }
}
