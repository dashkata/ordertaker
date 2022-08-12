class Reservation {
  final String userId;
  final String restaurantId;
  final String name;
  final String restaurant;
  final String date;
  final int numberOfPeople;

  Reservation({
    required this.userId,
    required this.restaurantId,
    required this.name,
    required this.restaurant,
    required this.date,
    required this.numberOfPeople,
  });

  factory Reservation.fromMap(
      Map fetchedReservation, String userId, String restaurantId) {
    return Reservation(
        userId: userId,
        restaurantId: restaurantId,
        name: fetchedReservation['personName'],
        restaurant: fetchedReservation['reservationTitle'],
        date: fetchedReservation['reservationDate'],
        numberOfPeople: fetchedReservation['reservationPeopleCount']);
  }

  Map<String, dynamic> toMap() {
    return ({
      'reservationTitle': restaurant,
      'reservationDate': date,
      'personName': name,
      'reservationPeopleCount': numberOfPeople,
    });
  }
}
