import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_app_level_two/data/api/api_services.dart';
import 'package:wisata_app_level_two/provider/main/index_nav_provider.dart';
import 'package:wisata_app_level_two/screen/main/main_screen.dart';
import 'package:wisata_app_level_two/style/typography/tourism_theme.dart';

import 'provider/detail/bookmark_list_provider.dart';
import 'provider/detail/tourism_detail_provider.dart';
import 'provider/home/tourism_list_provider.dart';
import 'screen/detail/detail_screen.dart';
import 'static/navigation_route.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkListProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => TourismListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TourismDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
          tourismId: ModalRoute.of(context)?.settings.arguments as int,
        ),
      },
    );
  }
}