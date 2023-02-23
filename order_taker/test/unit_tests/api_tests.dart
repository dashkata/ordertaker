import 'package:flutter_test/flutter_test.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';

import '../mocks/api_mock.dart';

void main() {
  final emptyAPI = EmptyMockAPI();
  final dataAPI = DataMockAPI();
  test('test restaurant fetching with empty data', () {
    expect(
      emptyAPI.fetchRestaurants(),
      const Stream<List<RestaurantEntity>>.empty(),
    );
  });
  test('test restaurant fetching with mock data', () async {
    final restaurantStream = dataAPI.fetchRestaurants();
    expect(
      await restaurantStream.single,
      [RestaurantEntity.empty()],
    );
  });
}
