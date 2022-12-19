import 'package:order_taker/data/api/firestore_api.dart';
import 'package:order_taker/data/entities/reservation_entity.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

class FirestoreRepository implements RestaurantRepo, ReservationRepo, UserRepo {
  final API _api;

  FirestoreRepository({required API api}) : _api = api;

  @override
  Future<Restaurant> fetchRestaurantInfo(String restaurant) async {
    final RestaurantEntity restaurantEntity =
        await _api.fetchRestaurantInfo(restaurant);
    return restaurantEntity.toRestaurant();
  }

  @override
  Future<String> fetchRestaurantTitle(String uid) async =>
      await _api.fetchRestaurantTitle(uid);

  @override
  Stream<List<Restaurant>> fetchRestaurants() {
    final Stream<List<RestaurantEntity>> apiRestaurants =
        _api.fetchRestaurants();
    return apiRestaurants.map(
      (stream) => stream
          .map((restaurantEntity) => restaurantEntity.toRestaurant())
          .toList(),
    );
  }

  @override
  Future<void> setRestaurantEmail(String email, String uid) async =>
      await _api.setRestaurantEmail(email, uid);

  @override
  Future<void> setRestaurantTitle(String restaurantName, String uid) async =>
      await _api.setRestaurantTitle(restaurantName, uid);

  @override
  Future<void> submitRestaurantDetails(
    Restaurant restaurant,
    int tables,
  ) async =>
      await _api.submitRestaurantDetails(
        RestaurantEntity.fromRestaurant(restaurant),
        tables,
      );

  @override
  Future<String?> getRestauarntEmail(String uid) =>
      _api.getRestauarntEmail(uid);

  @override
  Future<void> updateRestaurantInformation(
    String updatedInfo,
    String restaurantTitle,
    String detailType,
  ) =>
      _api.updateRestaurantInformation(
        updatedInfo,
        restaurantTitle,
        detailType,
      );

  Stream<List<Reservation>> fetchReservations(String uid) {
    final Stream<List<ReservationEntity>> reservations =
        _api.fetchReservations(uid);
    return reservations.map(
      (stream) => stream
          .map((reservationEntity) => reservationEntity.toReservation())
          .toList(),
    );
  }

  @override
  Future<void> addApprovedReservation(Reservation reservation) async =>
      await _api.addApprovedReservation(
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Future<void> addReservation(String uid, Reservation reservation) async =>
      await _api.addReservation(
        uid,
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Future<bool> checkForCurrentReservation(
          String restaurantTitle, int tableId) async =>
      await _api.checkForCurrentReservation(restaurantTitle, tableId);

  @override
  Future<bool> checkUserReservation(
          Reservation reservation, String uid) async =>
      await _api.checkUserReservation(
        ReservationEntity.fromReservation(reservation),
        uid,
      );

  @override
  Future<void> deleteReservation(String uid, Reservation reservation) async =>
      await _api.deleteReservation(
        uid,
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Stream<List<Reservation>> fetchRestaurantReservations(
    String restaurantTitle,
    int tableId,
  ) {
    final Stream<List<ReservationEntity>> reservations =
        _api.fetchRestaurantReservations(
      restaurantTitle,
      tableId,
    );
    return reservations.map(
      (stream) => stream
          .map((reservationEntity) => reservationEntity.toReservation())
          .toList(),
    );
  }

  @override
  Future<void> setCurrentReservation(
          String restaurantTitle, int tableId, Reservation reservation) async =>
      await _api.setCurrentReservation(
        restaurantTitle,
        tableId,
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Future<String> fetchMobileNumber(String uid) async =>
      await _api.fetchMobileNumber(uid);

  @override
  Future<bool> fetchOnBoarding(String uid) async =>
      await _api.fetchOnBoarding(uid);

  @override
  Future<String> fetchUserType(String uid) async =>
      await _api.fetchUserType(uid);

  @override
  Future<String> setMobileNumber(String uid, String mobileNumber) async =>
      await _api.setMobileNumber(uid, mobileNumber);

  @override
  Future<void> setOnBoarding(String uid, {required bool onBoarding}) async =>
      await _api.setOnBoarding(uid, onBoarding: onBoarding);

  @override
  Future<void> setUserType(String type, String uid) async =>
      await _api.setUserType(type, uid);
}
