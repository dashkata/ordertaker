import '../models/reservation_model.dart';

class FirestorePath {
  static String restaurants() => 'Restaurants';

  static String userReservations(String uid) => 'Users/$uid/Reservations';

  static String restaurantReservations(
    String restaurantTitle,
    int selectedTable,
  ) =>
      'Restaurants/$restaurantTitle/Tables/Table $selectedTable/Reservations';

  static String user(String uid) => 'Users/$uid';

  static String restaurant(String restaurantTitle) =>
      'Restaurants/$restaurantTitle';

  static String restaurantOrders(Reservation reservation, String uid) =>
      'Restaurants/${reservation.restaurant}/Tables/Table ${reservation.selectedTable}/Reservations/$uid - ${reservation.date}/Orders';

  static String restaurantTable(String tableId, String restaurant) =>
      'Restaurants/$restaurant/Tables/Table $tableId';

  static String restaurantTables(String restaurant) =>
      'Restaurants/$restaurant/Tables';
}
