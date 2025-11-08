import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinity_world/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  double _keyboardHeight = 0.0;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // code here
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _calculateKeyboardHeight() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      _keyboardHeight = bottomInset > 0 ? bottomInset : 0.0;
    });
  }

  void _login() async {
    // Điều hướng sang MainScreen
    // Navigator.pushReplacementNamed(context, AppRoutes.main);
    // GetX
    Get.offNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    _calculateKeyboardHeight();
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight - _keyboardHeight;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: (_keyboardHeight > 0) ? height / 2 : screenHeight / 2,
            left: 0,
            right: 0,
            child: Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: emailFocusNode,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow:
                                emailFocusNode.hasFocus
                                    ? [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 2.0,
                                        blurRadius: 5.0,
                                        offset: const Offset(0, 2), // Move shadow down and slightly to the right
                                      ),
                                    ]
                                    : null,
                            border: emailFocusNode.hasFocus ? Border.all(color: Colors.grey, width: 1.0) : null,
                          ),
                          child: TextField(
                            // This property controls whether the text input should be automatically corrected. Setting it to false disables automatic corrections.
                            autocorrect: false,
                            // This property controls autofill behavior. Setting it to null disables autofill.
                            autofillHints: null,
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xfff8fafc),
                              hintText: 'Enter your email',
                              hintStyle: const TextStyle(color: Color(0xff94a3b8)),
                              isDense: true,
                              prefixIcon: const Icon(Icons.email),
                            ),
                            // This property controls whether the keyboard should display suggestions. Setting it to false disables suggestions.
                            enableSuggestions: false,
                            focusNode: emailFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' '), // deny spaces for password
                              FilteringTextInputFormatter.allow(RegExp(r'[\x20-\x7E]')),
                            ],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    AnimatedBuilder(
                      animation: passwordFocusNode,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfff8fafc),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow:
                                passwordFocusNode.hasFocus
                                    ? [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 2.0,
                                        blurRadius: 5.0,
                                        offset: const Offset(0, 2), // Move shadow down and slightly to the right
                                      ),
                                    ]
                                    : null,
                            border: passwordFocusNode.hasFocus ? Border.all(color: Colors.grey, width: 1.0) : null,
                          ),
                          child: TextField(
                            autocorrect: false,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your password',
                              hintStyle: const TextStyle(color: Color(0xff94a3b8)),
                              isDense: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            enableSuggestions: false,
                            focusNode: passwordFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(' '), // deny spaces for password
                              FilteringTextInputFormatter.allow(RegExp(r'[\x20-\x7E]')),
                            ],
                            keyboardType: TextInputType.text,
                            obscureText: _obscureText,
                            textInputAction: TextInputAction.done,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(onPressed: _login, child: const Text('Sign in')),
                    // const SizedBox(height: 20),
                    // Text(
                    //   'Keyboard Height: $keyboardHeight',
                    //   style: const TextStyle(color: Colors.amber),
                    // ),
                    // const SizedBox(height: 10),
                    // Text(
                    //   'Screen Height: $height',
                    //   style: const TextStyle(color: Colors.amber),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
