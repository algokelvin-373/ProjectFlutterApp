import 'package:flutter/material.dart';
import 'package:wisata_app_level_two/screen/main/main_screen.dart';
import 'package:wisata_app_level_two/style/typography/tourism_theme.dart';

import 'model/tourism.dart';
import 'screen/detail/detail_screen.dart';
import 'screen/home/home_page.dart';
import 'static/navigation_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      // todo-04: add navigation route
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          tourism: ModalRoute.of(context)?.settings.arguments as Tourism,
        ),
      },
    );
  }
}