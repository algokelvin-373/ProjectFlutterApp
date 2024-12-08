import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app_level_one/main.dart';

import 'robot/evaluate_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("integrate all feature", (tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    // load ui
    await evaluateRobot.loadUI(const RestaurantApp(isDarkMode: true));

  });
}