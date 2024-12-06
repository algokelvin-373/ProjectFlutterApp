import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/model/restaurant.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_search_response.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_search_result.dart';


// Mock class
class MockApiServices extends Mock implements ApiServices {}

RestaurantSearchResponse sampleResponseSearchData() {
  return RestaurantSearchResponse(
    error: false,
    founded: 1,
    restaurants: [
      Restaurant(
        id: "uewq1zg2zlskfw1e867",
        name: "Kafein",
        description: "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. "
            "Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. "
            "Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, "
            "sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, "
            "luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. "
            "Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci "
            "eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. "
            "Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.",
        pictureId: "15",
        city: "Aceh",
        rating: 4.6,
      ),
    ],
  );
}

/*RestaurantSearchResponse getAllResSearchForEmptyKey() {
  return RestaurantSearchResponse(
    error: false,
    founded: 20,
    restaurants: [
      Restaurant(
        id: "uewq1zg2zlskfw1e867",
        name: "Kafein",
        description: "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. "
            "Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. "
            "Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, "
            "sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, "
            "luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. "
            "Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci "
            "eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. "
            "Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc.",
        pictureId: "15",
        city: "Aceh",
        rating: 4.6,
      ),
    ],
  );
}*/

RestaurantSearchResponse getResponseNotFound() {
  return RestaurantSearchResponse(
    error: false,
    founded: 0,
    restaurants: [],
  );
}


void main() {
  late MockApiServices mockApiServices;
  late RestaurantSearchProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantSearchProvider(mockApiServices);
  });

  group('Search Feature Tests', () {
    test('Should be verified the start of state', () {
      expect(provider.resultState, isA<RestaurantSearchNoneState>());
    });

    test('Should return search results when query matches data', () async {
      const keySearch = 'Kafein';
      final mockResponse = sampleResponseSearchData();
      when(() => mockApiServices.getRestaurantBySearch(keySearch))
        .thenAnswer((_) async => mockResponse);
      expect(provider.resultState, isA<RestaurantSearchNoneState>());

      final loadingStateFeature = provider.fetchRestaurantSearch(keySearch);
      expect(provider.resultState, isA<RestaurantSearchLoadingState>());
      await loadingStateFeature;

      expect(provider.resultState, isA<RestaurantSearchLoadedState>());
      final loadedState = provider.resultState as RestaurantSearchLoadedState;
      expect(loadedState.data, isNotEmpty);
      expect(loadedState.data[0].name, keySearch);
    });

    /*test('Should return list restaurant when key search is empty', () async {
      const keySearch = null;
      final mockResponse = getAllResSearchForEmptyKey();
      when(() => mockApiServices.getRestaurantBySearch(keySearch))
          .thenAnswer((_) async => mockResponse);
      expect(provider.resultState, isA<RestaurantSearchNoneState>());

      final loadingStateFeature = provider.fetchRestaurantSearch(keySearch);
      expect(provider.resultState, isA<RestaurantSearchLoadingState>());
      await loadingStateFeature;

      expect(provider.resultState, isA<RestaurantSearchLoadedState>());
      final loadedState = provider.resultState as RestaurantSearchLoadedState;
      expect(loadedState.data.length, 20);
    });*/

    test('Should return error message when failed to get search data', () async {
      const keySearch = 'Kafein';
      when(() => mockApiServices.getRestaurantBySearch(keySearch))
          .thenThrow(Exception('Failed to fetch data'));
      await provider.fetchRestaurantSearch(keySearch);

      expect(provider.resultState, isA<RestaurantSearchErrorState>());
      final errorState = provider.resultState as RestaurantSearchErrorState;
      expect(errorState.error, contains('Failed to fetch data'));
    });

    test('Should return empty data when query data is not found', () async {
      const keySearch = 'Pizza';
      final mockResponse = getResponseNotFound();
      when(() => mockApiServices.getRestaurantBySearch(keySearch))
          .thenAnswer((_) async => mockResponse);
      expect(provider.resultState, isA<RestaurantSearchNoneState>());

      final loadingStateFeature = provider.fetchRestaurantSearch(keySearch);
      expect(provider.resultState, isA<RestaurantSearchLoadingState>());
      await loadingStateFeature;

      expect(provider.resultState, isA<RestaurantSearchLoadedState>());
      final loadedState = provider.resultState as RestaurantSearchLoadedState;
      expect(loadedState.data, isEmpty);
    });
  });
}