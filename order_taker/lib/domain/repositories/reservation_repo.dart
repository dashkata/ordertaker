import '../models/reservation_model.dart';

abstract class ReservationRepo {
  Stream<List<Reservation>> fetchReservations(String uid);

  Stream<List<Reservation>> fetchRestaurantReservations(
    String restaurantTitle,
    int tableId,
  );

  Future<bool> checkForCurrentReservation(
    String restaurantTitle,
    int tableId,
  );

  Future<void> setCurrentReservation(
    String restaurantTitle,
    int tableId,
    Reservation reservation,
  );

  Future<bool> checkReservationOverlap(
    String restaurantTitle,
    int tableId,
    String reservationDate,
  );

  Future<void> addReservation(String uid, Reservation reservation);

  Future<void> deleteReservation(
    String uid,
    Reservation reservation,
  );

  Future<bool> checkUserReservation(
    Reservation reservation,
    String uid,
  );

  Future<void> addApprovedReservation(Reservation reservation);

  Stream<List<Reservation>> fetchRestaurantRequests(
    String restaurantTitle,
  );

  Future<void> disapproveRequest(Reservation reservation);
}
