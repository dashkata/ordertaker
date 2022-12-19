import 'package:order_taker/domain/models/restaurant_model.dart';

abstract class RestaurantRepo {
  Stream<List<Restaurant>> fetchRestaurants();

  Future<Restaurant> fetchRestaurantInfo(String restaurant);

  Future<void> setRestaurantTitle(String restaurantName, String uid);

  Future<String> fetchRestaurantTitle(String uid);

  Future<void> submitRestaurantDetails(
    Restaurant restaurant,
    int tables,
  );

  Future<void> setRestaurantEmail(String email, String uid);

  Future<String?> getRestauarntEmail(String uid);

  Future<void> updateRestaurantInformation(
    String updatedInfo,
    String restaurantTitle,
    String detailType,
  );
}
