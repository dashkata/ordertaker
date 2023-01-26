import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../mocks/api_mock.dart';

void main() {
  final emptyContainer = ProviderContainer(
    overrides: [apiProvider.overrideWith((ref) => EmptyMockAPI())],
  );
  final dataContainer = ProviderContainer(
    overrides: [apiProvider.overrideWith((ref) => DataMockAPI())],
  );
  test('test restaurant fetching with empty data', () {
    expect(
      emptyContainer.read(apiProvider).fetchRestaurants(),
      const Stream<List<RestaurantEntity>>.empty(),
    );
  });
  test('test restaurant fetching with mock data', () async {
    final restaurantStream = dataContainer.read(apiProvider).fetchRestaurants();
    expect(
      await restaurantStream.single,
      [RestaurantEntity.empty()],
    );
  });
}
