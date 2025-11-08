import 'package:cuenta/config/router/router_config.dart';
import 'package:cuenta/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      themeMode: ThemeMode.system,
      theme: AppTheme(selectedColor: 1).themeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
