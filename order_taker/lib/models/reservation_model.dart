class Reservation {
  final String name;
  final String restaurant;
  final String date;
  final int numberOfPeople;
  final int selectedTable;

  Reservation({
    required this.name,
    required this.restaurant,
    required this.date,
    required this.numberOfPeople,
    required this.selectedTable,
  });

  factory Reservation.fromMap(Map fetchedReservation) => Reservation(
        name: fetchedReservation['personName'],
        restaurant: fetchedReservation['reservationTitle'],
        date: fetchedReservation['reservationDate'],
        numberOfPeople: fetchedReservation['reservationPeopleCount'],
        selectedTable: fetchedReservation['selectedTable'],
      );

  Map<String, dynamic> toMap() => {
        'reservationTitle': restaurant,
        'reservationDate': date,
        'personName': name,
        'reservationPeopleCount': numberOfPeople,
        'selectedTable': selectedTable,
      };
}
