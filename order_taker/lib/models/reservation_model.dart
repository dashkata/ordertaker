class Reservation {
  final String name;
  final String restaurant;
  final String date;
  final int numberOfPeople;

  Reservation({
    required this.name,
    required this.restaurant,
    required this.date,
    required this.numberOfPeople,
  });

  factory Reservation.fromMap(Map fetchedReservation) {
    return Reservation(
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
