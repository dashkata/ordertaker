class Reservation {
  final String name;
  final String restaurant;
  final String date;
  final int numberOfPeople;
  final int selectedTable;
  final bool? currentReservation;

  Reservation(
      {required this.name,
      required this.restaurant,
      required this.date,
      required this.numberOfPeople,
      required this.selectedTable,
      required this.currentReservation});

  factory Reservation.fromMap(Map fetchedReservation) => Reservation(
        name: fetchedReservation['personName'],
        restaurant: fetchedReservation['reservationTitle'],
        date: fetchedReservation['reservationDate'],
        numberOfPeople: fetchedReservation['reservationPeopleCount'],
        selectedTable: fetchedReservation['selectedTable'],
        currentReservation: fetchedReservation['currentReservation'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'reservationTitle': restaurant,
        'reservationDate': date,
        'personName': name,
        'reservationPeopleCount': numberOfPeople,
        'selectedTable': selectedTable,
      };
}
