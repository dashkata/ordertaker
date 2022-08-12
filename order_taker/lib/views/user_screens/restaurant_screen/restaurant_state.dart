import 'package:order_taker/models/restaurant_model.dart';

abstract class RestaurantState {
  const RestaurantState();
}

class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantLoaded(this.restaurants);
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);
}
