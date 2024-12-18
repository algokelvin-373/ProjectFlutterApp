import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_level_two/db/auth_repository.dart';
import 'package:story_app_level_two/flavor_config.dart';
import 'package:story_app_level_two/provider/auth/auth_provider.dart';
import 'package:story_app_level_two/provider/upload/upload_provider.dart';
import 'package:story_app_level_two/routes/route_information_parser.dart';
import 'package:story_app_level_two/routes/router_delegate.dart';

import 'data/api/api_services.dart';
import 'provider/detail/story_detail_provider.dart';
import 'provider/home/story_list_provider.dart';
import 'provider/main/index_nav_provider.dart';
import 'provider/theme/theme_provider.dart';
import 'style/typography/restaurant_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  FlavorConfig(
    flavor: FlavorType.free,
    values: const FlavorValues(titleApp: "Free"),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiServices()),
        Provider(create: (_) => AuthRepository()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()),
        ChangeNotifierProvider(
          create: (context) => StoryListProvider(
            context.read<ApiServices>(),
            context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryDetailProvider(
            context.read<AuthRepository>(),
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadProvider(
            context.read<ApiServices>(),
            context.read<AuthRepository>(),
          ),
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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: myRouterDelegate,
            routeInformationParser: myRouteInformationParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
