import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/auth/application/session_providers.dart';
import 'package:infinity_world/app/router/app_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _displayNameController = TextEditingController();
  final _displayNameFocusNode = FocusNode();

  String? _displayNameError;
  bool _isLoggingIn = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _displayNameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoggingIn) {
      return;
    }

    final displayName = _displayNameController.text.trim();
    if (displayName.isEmpty) {
      setState(() {
        _displayNameError = 'Enter a display name';
      });
      return;
    }

    setState(() {
      _displayNameError = null;
      _isLoggingIn = true;
    });

    try {
      await ref
          .read(localSessionRepositoryProvider)
          .saveSession(displayName: displayName);
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.main);
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Image.asset(
              'assets/images/login_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
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
                        child: IwCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Local profile',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Choose the name InfinityWorld uses on this device.',
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              AnimatedBuilder(
                                animation: _displayNameFocusNode,
                                builder: (context, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow:
                                          _displayNameFocusNode.hasFocus
                                              ? [
                                                const BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                ),
                                              ]
                                              : null,
                                      border:
                                          _displayNameFocusNode.hasFocus
                                              ? Border.all(color: Colors.grey)
                                              : null,
                                    ),
                                    child: TextField(
                                      autofillHints: const [AutofillHints.name],
                                      controller: _displayNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        errorText: _displayNameError,
                                        filled: true,
                                        fillColor: const Color(0xfff8fafc),
                                        hintText: 'Display name',
                                        hintStyle: const TextStyle(
                                          color: Color(0xff94a3b8),
                                        ),
                                        isDense: true,
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                      focusNode: _displayNameFocusNode,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(40),
                                      ],
                                      keyboardType: TextInputType.name,
                                      onChanged: (_) {
                                        if (_displayNameError == null) {
                                          return;
                                        }
                                        setState(() {
                                          _displayNameError = null;
                                        });
                                      },
                                      onSubmitted: (_) => _login(),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isLoggingIn ? null : _login,
                                child: Text(
                                  _isLoggingIn
                                      ? 'Entering...'
                                      : 'Enter InfinityWorld',
                                ),
                              ),
                            ],
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
