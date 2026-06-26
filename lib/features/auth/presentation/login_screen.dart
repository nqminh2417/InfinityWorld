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

  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    Get.offNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/login_background.jpg', fit: BoxFit.cover),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                  animation: emailFocusNode,
                                  builder: (context, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        boxShadow:
                                            emailFocusNode.hasFocus
                                                ? [
                                                  const BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2.0,
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ]
                                                : null,
                                        border:
                                            emailFocusNode.hasFocus
                                                ? Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )
                                                : null,
                                      ),
                                      child: TextField(
                                        autocorrect: false,
                                        autofillHints: null,
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xfff8fafc),
                                          hintText: 'Enter your email',
                                          hintStyle: const TextStyle(
                                            color: Color(0xff94a3b8),
                                          ),
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.email),
                                        ),
                                        enableSuggestions: false,
                                        focusNode: emailFocusNode,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(' '),
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[\x20-\x7E]'),
                                          ),
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
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        boxShadow:
                                            passwordFocusNode.hasFocus
                                                ? [
                                                  const BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2.0,
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ]
                                                : null,
                                        border:
                                            passwordFocusNode.hasFocus
                                                ? Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                )
                                                : null,
                                      ),
                                      child: TextField(
                                        autocorrect: false,
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Enter your password',
                                          hintStyle: const TextStyle(
                                            color: Color(0xff94a3b8),
                                          ),
                                          isDense: true,
                                          prefixIcon: const Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
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
                                          FilteringTextInputFormatter.deny(' '),
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[\x20-\x7E]'),
                                          ),
                                        ],
                                        keyboardType: TextInputType.text,
                                        obscureText: _obscureText,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _login,
                                  child: const Text('Sign in'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
