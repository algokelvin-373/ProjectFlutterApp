import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/provider/notification/notification_provider.dart';
import 'package:restaurant_app_level_one/provider/theme/theme_provider.dart';
import 'package:restaurant_app_level_one/screen/home/food_list_widget.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen_body_widget.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';

//import 'restaurant_list_loading_widget_test.mocks.dart';

// class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}
// class MockApiServices extends Mock implements ApiServices {}
//
//
// class MockRestaurantSearchProvider extends Mock implements RestaurantSearchProvider {}

/*void main() {
  late MockRestaurantListProvider mockProvider;
  late MockRestaurantSearchProvider mockSearchProvider;
  late MockNotificationProvider mockNotificationProvider;
  late MockThemeProvider mockThemeProvider;

  setUpAll(() {
    registerFallbackValue(RestaurantListLoadingState());
  });

  setUp(() {
    mockProvider = MockRestaurantListProvider();
    mockSearchProvider = MockRestaurantSearchProvider(); // Menambahkan Mock untuk RestaurantSearchProvider
    mockNotificationProvider = MockNotificationProvider();
    mockThemeProvider = MockThemeProvider();
  });

  testWidgets('Should show loading indicator when data is loading', (tester) async {
    // Membuat controller untuk searchController
    final searchController = TextEditingController();

    when(() => mockThemeProvider.isDarkMode).thenReturn(false); // atau true sesuai kebutuhan
    when(() => mockNotificationProvider.isReminderOn).thenReturn(true); // jika ada

    print('Mock Theme state: ${mockThemeProvider.isDarkMode}');

    // Mock state sebagai loading
    when(() => mockProvider.resultState).thenReturn(RestaurantListLoadingState());

    // Print untuk memverifikasi apakah status benar
    print('Mock state: ${mockProvider.resultState}');

    // Pump HomeScreen dengan provider mock yang sesuai
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ApiServices>(create: (_) => MockApiServices()),
          ChangeNotifierProvider<RestaurantListProvider>(
            create: (_) => mockProvider,
          ),
          ChangeNotifierProvider<RestaurantSearchProvider>(
            create: (_) => mockSearchProvider, // Menambahkan RestaurantSearchProvider mock
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => mockThemeProvider,
          ),
          ChangeNotifierProvider<NotificationProvider>(
            create: (_) => mockNotificationProvider,
          ),
          // Tambahkan provider mock lainnya sesuai kebutuhan
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Verifikasi bahwa CircularProgressIndicator ada
    final progressIndicator = find.byType(CircularProgressIndicator);
    print('Found CircularProgressIndicator: ${progressIndicator.evaluate().isEmpty}');
    expect(progressIndicator, findsOneWidget);
  });
}*/

class MockThemeProvider extends Mock implements ThemeProvider {}
class MockNotificationProvider extends Mock implements NotificationProvider {}
class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}

void main() {
  late MockThemeProvider mockThemeProvider;
  late MockNotificationProvider mockNotificationProvider;
  late MockRestaurantListProvider mockRestaurantListProvider;

  setUp(() {
    mockThemeProvider = MockThemeProvider();
    mockNotificationProvider = MockNotificationProvider();
    mockRestaurantListProvider = MockRestaurantListProvider();
  });

  group('Home Screen Test', () {
    testWidgets('Should toggle theme icon', (tester) async {
      // Menentukan nilai awal untuk isDarkMode
      when(() => mockThemeProvider.isDarkMode).thenReturn(false);

      when(() => mockNotificationProvider.isReminderOn).thenReturn(false);

      // Melakukan mock pada toggleTheme
      when(() => mockThemeProvider.toggleTheme()).thenAnswer((_) {
        when(() => mockThemeProvider.isDarkMode).thenReturn(true);
      });

      // Mock provider RestaurantList
      when(() => mockRestaurantListProvider.resultState).thenReturn(RestaurantListLoadingState());

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>(create: (_) => mockThemeProvider),
            ChangeNotifierProvider<NotificationProvider>(create: (_) => mockNotificationProvider),
            ChangeNotifierProvider<RestaurantListProvider>(create: (_) => mockRestaurantListProvider), // Tambahkan ini
          ],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      // Verifikasi ikon awal (misal: sunny)
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);

      // Tap tombol untuk ganti tema
      await tester.tap(find.byIcon(Icons.wb_sunny));
      await tester.pump();

      // Verifikasi ikon berubah (misal: moon)
      expect(find.byIcon(Icons.nightlight_round), findsOneWidget);

      // Verifikasi bahwa toggleTheme dipanggil
      verify(() => mockThemeProvider.toggleTheme()).called(1);
    });
  });
}
