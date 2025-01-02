import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/main.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_level_one/provider/notification/notification_provider.dart';
import 'package:restaurant_app_level_one/provider/theme/theme_provider.dart';

import '../robot/evaluate_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration List Restaurant', (tester) async {
    final evaluateRobot = EvaluateRobot(tester);
    final apiServices = ApiServices();

    await evaluateRobot.loadUI(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => IndexNavProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(
              create: (_) => RestaurantListProvider(apiServices)),
          ChangeNotifierProvider(
              create: (_) => RestaurantSearchProvider(apiServices)),
        ],
        child: const RestaurantApp(isDarkMode: true),
      ),
    );

    await tester.pumpAndSettle();

    // Show List Restaurant
    await evaluateRobot.showListRestaurant();
  });
}
