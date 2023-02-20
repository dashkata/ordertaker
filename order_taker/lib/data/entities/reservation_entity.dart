import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/domain/models/reservation_model.dart';

class ReservationEntity {
  final String userId;
  final String name;
  final RestaurantEntity restaurant;
  final String date;
  final String preferredLocation;
  final int numberOfPeople;
  final int? table;
  final bool? currentReservation;
  final bool? approved;

  ReservationEntity({
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

  factory ReservationEntity.fromMap(Map fetchedReservation) =>
      ReservationEntity(
        userId: fetchedReservation['userId'],
        name: fetchedReservation['personName'],
        restaurant: RestaurantEntity.fromMap(fetchedReservation['restaurant']),
        date: fetchedReservation['reservationDate'],
        numberOfPeople: fetchedReservation['reservationPeopleCount'],
        table: fetchedReservation['table'] ?? 0,
        currentReservation: fetchedReservation['currentReservation'] ?? false,
        approved: fetchedReservation['approved'],
        preferredLocation: fetchedReservation['preferredLocation'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'restaurant': restaurant.toMap(),
        'reservationDate': date,
        'personName': name,
        'reservationPeopleCount': numberOfPeople,
        'preferredLocation': preferredLocation,
        'approved': approved,
        'table': table,
      };

  Reservation toReservation() => Reservation(
        userId: userId,
        name: name,
        restaurant: restaurant.toRestaurant(),
        date: date,
        numberOfPeople: numberOfPeople,
        preferredLocation: preferredLocation,
        currentReservation: currentReservation,
        table: table,
        approved: approved,
      );

  factory ReservationEntity.fromReservation(Reservation reservation) =>
      ReservationEntity(
        userId: reservation.userId,
        name: reservation.name,
        restaurant: RestaurantEntity.fromRestaurant(reservation.restaurant),
        date: reservation.date,
        numberOfPeople: reservation.numberOfPeople,
        preferredLocation: reservation.preferredLocation,
        currentReservation: reservation.currentReservation,
        table: reservation.table,
        approved: reservation.approved,
      );
}
