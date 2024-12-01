import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen.dart';
import 'package:restaurant_app_level_one/style/typography/restaurant_theme.dart';

import 'screen/detail/detail_screen.dart';
import 'static/navigation_route.dart';

void main() {
  //runApp(const RestaurantApp());
  runApp(
    MultiProvider(
      providers: [
        /*ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(),
        ),*/
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: const RestaurantApp(),
    ),
  );
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.homeRoute.name,
      routes: {
        NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => const DetailScreen(),
      },
    );
  }
}
