import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/model/menu.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail.dart';
import 'package:restaurant_app_level_one/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_detail_result.dart';

class MockApiServices extends Mock implements ApiServices {}

RestaurantDetailResponse sampleResRestaurantDetail = RestaurantDetailResponse(
  error: false,
  message: "success",
  restaurant: sampleRestaurantDetail,
);

RestaurantDetailResponse sampleResRestaurantDetailNull = RestaurantDetailResponse(
  error: true,
  message: "Not Found",
  restaurant: RestaurantDetail.empty(),
);

RestaurantDetail sampleRestaurantDetail = RestaurantDetail(
  id: "rqdv5juczeskfw1e867",
  name: "Melting Pot",
  description:
  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.",
  city: "Medan",
  address: "Jln. Pandeglang no 19",
  pictureId: "14",
  categories: [],
  menus: Menu.empty(),
  rating: 4.2,
  customerReviews: [],
);

void main() {
  late MockApiServices mockApiServices;
  late RestaurantDetailProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantDetailProvider(mockApiServices);
  });

  group('Restaurant Detail Test', () {
    test('Should be verified the start of state', () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test('Should return restaurant detail if ID Restaurant is valid', () async {
      const id = 'rqdv5juczeskfw1e867';
      final mockResponse = sampleResRestaurantDetail;
      when(() => mockApiServices.getRestaurantDetail(id))
          .thenAnswer((_) async => mockResponse);
      expect(provider.resultState, isA<RestaurantDetailNoneState>());

      final loadingStateFeature = provider.fetchRestaurantDetail(id);
      expect(provider.resultState, isA<RestaurantDetailLoadingState>());
      await loadingStateFeature;

      expect(provider.resultState, isA<RestaurantDetailLoadedState>());
      final loadedState = provider.resultState as RestaurantDetailLoadedState;
      expect(loadedState.data.name, 'Melting Pot'); // Verify Name
      expect(loadedState.data.city, 'Medan'); // Verify City
      expect(loadedState.data.address, 'Jln. Pandeglang no 19'); // Verify Address
    });

    test('Should return null if ID is not valid', () async {
      const id = 'rqdv5juczeskfw1e';
      final mockResponse = sampleResRestaurantDetailNull;
      when(() => mockApiServices.getRestaurantDetail(id))
          .thenAnswer((_) async => mockResponse);
      expect(provider.resultState, isA<RestaurantDetailNoneState>());

      final loadingStateFeature = provider.fetchRestaurantDetail(id);
      expect(provider.resultState, isA<RestaurantDetailLoadingState>());
      await loadingStateFeature;

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      final loadedState = provider.resultState as RestaurantDetailErrorState;
      expect(loadedState.error, 'Not Found');
    });
  });
}