import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_level_two/db/auth_repository.dart';
import 'package:story_app_level_two/provider/auth/auth_provider.dart';
import 'package:story_app_level_two/routes/route_information_parser.dart';
import 'package:story_app_level_two/routes/router_delegate.dart';

import 'data/api/api_services.dart';
import 'data/local/db_service.dart';
import 'provider/detail/restaurant_detail_provider.dart';
import 'provider/detail/restaurant_review_provider.dart';
import 'provider/favorite/db_provider.dart';
import 'provider/home/restaurant_list_provider.dart';
import 'provider/home/restaurant_search_provider.dart';
import 'provider/main/index_nav_provider.dart';
import 'provider/notification/notification_provider.dart';
import 'provider/theme/theme_provider.dart';
import 'service/notification_service.dart';
import 'style/typography/restaurant_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.requestNotificationPermission();
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ApiServices(),
        ),
        Provider(
          create: (_) => DbService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DbProvider(context.read<DbService>()),
        ),
      ],
      child: StoryApp(isDarkMode: isDarkMode),
    ),
  );
}

class StoryApp extends StatefulWidget {
  final bool isDarkMode;

  const StoryApp({super.key, required this.isDarkMode});

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {
  late MyRouteInformationParser myRouteInformationParser;
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final apiServices = ApiServices();
    authProvider = AuthProvider(authRepository, apiServices);

    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: Consumer<ThemeProvider>(
        builder: (_, value, __) {
          return MaterialApp.router(
            title: 'Story App',
            theme: RestaurantTheme.lightTheme,
            darkTheme: RestaurantTheme.darkTheme,
            themeMode: value.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerDelegate: myRouterDelegate,
            routeInformationParser: myRouteInformationParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
