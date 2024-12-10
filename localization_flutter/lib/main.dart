import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common.dart';
import 'home.dart';
import 'localization_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalizationProvider>(
      create: (context) => LocalizationProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocalizationProvider>(context);
        return MaterialApp(
          title: 'Flutter Localization & Accessibility',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.grey.shade50,
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade800,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: provider.locale,
          home: const HomePage(),
        );
      },
    );
  }
}
