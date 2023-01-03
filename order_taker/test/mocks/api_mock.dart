import 'package:flutter_test/flutter_test.dart';
import 'package:order_taker/data/api/firestore_api.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';

class EmptyMockAPI extends Fake implements API {
  @override
  Stream<List<RestaurantEntity>> fetchRestaurants() => const Stream.empty();
}

class DataMockAPI extends Fake implements API {
  @override
  Stream<List<RestaurantEntity>> fetchRestaurants() =>
      Stream.value([RestaurantEntity.empty()]);
}
