import 'package:order_taker/domain/models/restaurant_model.dart';

class ConfirmReservationArguments {
  ConfirmReservationArguments({
    required this.restaurant,
    required this.userDate,
    required this.numberOfPeople,
    required this.preferredLocation,
  });

  final Restaurant restaurant;
  final String userDate;
  final int numberOfPeople;
  final String preferredLocation;
}
