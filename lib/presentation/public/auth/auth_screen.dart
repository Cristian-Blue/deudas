import 'package:cuenta/presentation/public/auth/header_widget.dart';
import 'package:cuenta/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Providers
import 'package:cuenta/providers/theme_provider.dart';
import 'package:cuenta/providers/languaje_provider.dart';

// Localizations
import 'package:cuenta/l10n/app_localizations.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  void _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.completeFields)),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    final error = await AuthService.getToken(
      _userController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (error == null) {
      context.goNamed('Products');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              HeaderWidget(200),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// USERNAME
                      TextFormField(
                        controller: _userController,
                        decoration: InputDecoration(
                          labelText: t.username,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? t.usernameRequired
                              : null;
                        },
                      ),

                      const SizedBox(height: 16),

                      /// PASSWORD
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: t.password,
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? t.passwordRequired
                              : null;
                        },
                      ),

                      const SizedBox(height: 16),

                      /// LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          label: Text(t.login),
                          onPressed: _loading ? null : () => _login(context),
                          icon: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.login),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// THEME BUTTON 🌙☀️
                      IconButton.filled(
                        onPressed: () {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                        icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                      ),

                      const SizedBox(height: 16),

                      /// LANGUAGE BUTTONS 🌎
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(languageProvider.notifier)
                                  .changeLanguage('es');
                            },
                            child: const Text("ES"),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(languageProvider.notifier)
                                  .changeLanguage('en');
                            },
                            child: const Text("EN"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
