import 'package:order_taker/domain/models/reservation_model.dart';

class FirestorePath {
  static String restaurants() => 'Restaurants';

  static String userReservations(String uid) => 'Users/$uid/Reservations';

  static String userReservation(
    String uid,
    String restaurantTitle,
    String date,
  ) =>
      'Users/$uid/Reservations/$restaurantTitle - $date';

  static String restaurantReservations(
    String restaurantTitle,
    int selectedTable,
  ) =>
      'Restaurants/$restaurantTitle/Tables/Table $selectedTable/Reservations';

  static String user(String uid) => 'Users/$uid';

  static String restaurant(String restaurantTitle) =>
      'Restaurants/$restaurantTitle';

  static String restaurantOrders(Reservation reservation, String uid) =>
      'Restaurants/${reservation.restaurant}/Tables/Table ${reservation.table}/Reservations/$uid - ${reservation.date}/Orders';

  static String restaurantTableReservations(
          String tableId, String restaurant) =>
      'Restaurants/$restaurant/Tables/Table $tableId/Reservations';

  static String restaurantTable(String tableId, String restaurant) =>
      'Restaurants/$restaurant/Tables/Table $tableId';

  static String restaurantTables(String restaurant) =>
      'Restaurants/$restaurant/Tables';

  static String restaurantMenuType(String restaurant, String itemType) =>
      'Restaurants/$restaurant/Menu/$itemType';

  static String restaurantMenu(String restaurant) =>
      'Restaurants/$restaurant/Menu';

  static String restaurantReviews(String restaurant) =>
      'Restaurants/$restaurant/Reviews';

  static String restaurantRequests(String restaurantTitle) =>
      'Restaurants/$restaurantTitle/Requests';

  static String restaurantRequest(
          String restaurantTitle, String userId, String date) =>
      'Restaurants/$restaurantTitle/Requests/$userId - $date';
}
