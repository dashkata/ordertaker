class ConfirmReservationArguments {
  ConfirmReservationArguments({
    required this.restaurantTitle,
    required this.userDate,
    required this.numberOfPeople,
    required this.preferredLocation,
  });

  final String restaurantTitle;
  final String userDate;
  final int numberOfPeople;
  final String preferredLocation;
}
