import 'package:order_taker/data/api/firestore_api.dart';
import 'package:order_taker/data/entities/menu_item_entity.dart';
import 'package:order_taker/data/entities/menu_section_entity.dart';
import 'package:order_taker/data/entities/order_entity.dart';
import 'package:order_taker/data/entities/reservation_entity.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/data/entities/review_entity.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/domain/repositories/menu_repo.dart';
import 'package:order_taker/domain/repositories/order_repo.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/review_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

class DatabaseRepository
    implements
        RestaurantRepo,
        ReservationRepo,
        UserRepo,
        MenuRepo,
        ReviewRepo,
        OrderRepo {
  final API _api;

  DatabaseRepository({required API api}) : _api = api;

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

  @override
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

  @override
  Future<void> disapproveRequest(Reservation reservation) async =>
      await _api.disapproveRequest(
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Stream<List<Reservation>> fetchRestaurantRequests(String restaurantTitle) {
    final Stream<List<ReservationEntity>> reservations =
        _api.fetchRestaurantRequests(restaurantTitle);
    return reservations.map(
      (stream) =>
          stream.map((reservation) => reservation.toReservation()).toList(),
    );
  }

  @override
  Future<void> addMenuItem(OrderItem orderItem, String restaurant) async =>
      await _api.addMenuItem(
        OrderItemEntity.fromOrderItem(orderItem),
        restaurant,
      );

  @override
  Future<void> changeMenuItemStatus({
    required bool status,
    required String restaurantTitle,
    required OrderItem item,
  }) async =>
      await _api.changeMenuItemStatus(
        status: status,
        restaurantTitle: restaurantTitle,
        item: OrderItemEntity.fromOrderItem(item),
      );

  @override
  Stream<List<MenuSection>> fetchMenu(String title) {
    final Stream<List<MenuSectionEntity>> menuSectionStream =
        _api.fetchMenu(title);
    return menuSectionStream.map(
      (stream) =>
          stream.map((menuSection) => menuSection.toMenuSection()).toList(),
    );
  }

  @override
  Future<void> removeMenuItem({
    required OrderItem item,
    required String restaurantTitle,
  }) async =>
      await _api.removeMenuItem(
        item: OrderItemEntity.fromOrderItem(item),
        restaurantTitle: restaurantTitle,
      );

  @override
  Future<void> addRestaurantReview(
    String restaurantTitle,
    Review review,
  ) async =>
      await _api.addRestaurantReview(
        restaurantTitle,
        ReviewEntity.fromReview(review),
      );

  @override
  Stream<List<Review>> fetchReviews(String restaurantTitle) {
    final Stream<List<ReviewEntity>> reviewStream =
        _api.fetchReviews(restaurantTitle);
    return reviewStream
        .map((stream) => stream.map((review) => review.toReview()).toList());
  }

  @override
  Future<void> completeOrder(
    UserOrder orders,
    String uid,
    Reservation reservation,
  ) async =>
      await _api.completeOrder(
        UserOrderEntity.fromUserOrder(orders),
        uid,
        ReservationEntity.fromReservation(reservation),
      );

  @override
  Stream<List<UserOrder>> fetchOrdersRestaurant(
      String tableId, String restaurant) {
    final Stream<List<UserOrderEntity>> orderStream =
        _api.fetchOrdersRestaurant(tableId, restaurant);
    return orderStream.map(
      (stream) => stream.map((order) => order.toUserOrder()).toList(),
    );
  }

  @override
  Stream<List<UserOrder>> fetchOrdersUser(Reservation reservation, String uid) {
    final Stream<List<UserOrderEntity>> orderStream = _api.fetchOrdersUser(
      ReservationEntity.fromReservation(reservation),
      uid,
    );
    return orderStream.map(
      (stream) => stream.map((order) => order.toUserOrder()).toList(),
    );
  }

  @override
  Future<void> updateOrderStatus(
    int id,
    String orderStatus,
    String tableId,
    String restaurantTitle,
  ) async =>
      await _api.updateOrderStatus(id, orderStatus, tableId, restaurantTitle);

  @override
  Future<bool> checkReservationOverlap(
    String restaurantTitle,
    int tableId,
    String reservationDate,
  ) async =>
      await _api.checkReservationOverlap(
        restaurantTitle,
        tableId,
        reservationDate,
      );
}
