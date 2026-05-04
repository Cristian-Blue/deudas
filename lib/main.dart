import 'package:cuenta/config/router/router_config.dart';
import 'package:cuenta/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:cuenta/providers/languaje_provider.dart';
import 'package:cuenta/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cuenta/l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: appRouter,

      themeMode: theme ? ThemeMode.dark : ThemeMode.light,
      locale: language,

      theme: AppTheme(selectedColor: 1).themeData(theme),
      darkTheme: ThemeData.dark(),

      debugShowCheckedModeBanner: false,

      supportedLocales: const [Locale('es'), Locale('en')],

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
