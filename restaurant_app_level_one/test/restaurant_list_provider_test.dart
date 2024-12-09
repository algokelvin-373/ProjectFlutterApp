import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/model/restaurant.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_list_response.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';


// Mock class
class MockApiServices extends Mock implements ApiServices {}

RestaurantListResponse sampleResponseData() {
  return RestaurantListResponse(
    error: false,
    message: 'success',
    count: 20,
    restaurants: [
      Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description: 'Lorem ipsum dolor sit amet...',
        pictureId: '14',
        city: 'Medan',
        rating: 4.2,
      ),
      Restaurant(
        id: 's1knt6za9kkfw1e867',
        name: 'Kafe Kita',
        description: 'Quisque rutrum...',
        pictureId: '25',
        city: 'Gorontalo',
        rating: 4.0,
      ),
    ],
  );
}

RestaurantListResponse responseErrorData() {
  return RestaurantListResponse(
    error: true,
    message: 'Error',
    count: 0,
    restaurants: [],
  );
}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockApiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(mockApiServices);
  });

  test('should define initial state of provider', () {
    // Pastikan state awal adalah RestaurantListNoneState
    expect(restaurantListProvider.resultState, isA<RestaurantListNoneState>());
  });

  test('should return loading state before data is loaded', () async {
    final mockResponse = sampleResponseData(); // Mock response data

    // Mock API call to return the mockResponse
    when(() => mockApiServices.getRestaurantList())
        .thenAnswer((_) async => mockResponse);

    // Ensure that the provider starts with the correct initial state (NoneState)
    expect(restaurantListProvider.resultState, isA<RestaurantListNoneState>());

    // Call fetchRestaurantList and check loading state first
    // We need to wait a bit to ensure loading state is captured before the data is returned.
    final loadingStateFuture = restaurantListProvider.fetchRestaurantList();

    // Ensure that the state is loading while the API request is being made
    expect(restaurantListProvider.resultState, isA<RestaurantListLoadingState>());

    // Wait for the API call to complete
    await loadingStateFuture;

    // After fetching, verify the final state (should be loaded state)
    expect(restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
    final loadedState = restaurantListProvider.resultState as RestaurantListLoadedState;
    expect(loadedState.data, isNotEmpty);
    expect(loadedState.data[0].name, 'Melting Pot'); // Verify the first restaurant name
  });

  test('should return error state if API call fails', () async {
    // Mock API to throw an exception or return an error response
    when(() => mockApiServices.getRestaurantList()).thenAnswer(
            (_) async => responseErrorData());

    // Ensure that the provider starts with the correct initial state (NoneState)
    expect(restaurantListProvider.resultState, isA<RestaurantListNoneState>());

    // Call fetchRestaurantList and check loading state first
    // We need to wait a bit to ensure loading state is captured before the data is returned.
    final loadingStateFuture = restaurantListProvider.fetchRestaurantList();

    // Ensure that the state is loading while the API request is being made
    expect(restaurantListProvider.resultState, isA<RestaurantListLoadingState>());

    // Wait for the API call to complete
    await loadingStateFuture;

    // After fetching, verify the final state (should be error state)
    expect(restaurantListProvider.resultState, isA<RestaurantListErrorState>());
    final errorState = restaurantListProvider.resultState as RestaurantListErrorState;
    expect(errorState.error, 'Error'); // Verify error message
  });
}