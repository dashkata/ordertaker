import 'package:order_taker/domain/models/restaurant_model.dart';

class Reservation {
  final String userId;
  final String name;
  final Restaurant restaurant;
  final String date;
  final String preferredLocation;
  final int numberOfPeople;
  final int? table;
  final bool? currentReservation;
  final bool? approved;

  Reservation({
    required this.userId,
    required this.name,
    required this.restaurant,
    required this.date,
    required this.numberOfPeople,
    required this.preferredLocation,
    this.currentReservation,
    this.table,
    this.approved,
  });

  factory Reservation.fromMap(Map fetchedReservation) => Reservation(
        userId: fetchedReservation['userId'],
        name: fetchedReservation['personName'],
        restaurant: fetchedReservation['reservationTitle'],
        date: fetchedReservation['reservationDate'],
        numberOfPeople: fetchedReservation['reservationPeopleCount'],
        table: fetchedReservation['table'] ?? 0,
        currentReservation: fetchedReservation['currentReservation'] ?? false,
        approved: fetchedReservation['approved'],
        preferredLocation: fetchedReservation['preferredLocation'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'reservationTitle': restaurant,
        'reservationDate': date,
        'personName': name,
        'reservationPeopleCount': numberOfPeople,
        'preferredLocation': preferredLocation,
        'approved': approved,
        'table': table,
      };

  factory Reservation.empty() => Reservation(
        userId: '',
        name: '',
        restaurant: Restaurant.empty(),
        date: '',
        numberOfPeople: 0,
        preferredLocation: '',
      );
}
