import 'package:order_taker/models/reservation_model.dart';

class FirestorePath {
  static String restaurants() => "Restaurants";

  static String userReservations(String uid) => "Users/$uid/Reservations";

  static String restaurantReservations(
          String restaurantTitle, int selectedTable) =>
      "Restaurants/$restaurantTitle/Table $selectedTable";

  static String user(String uid) => "Users/$uid";

  static String restaurant(String restaurantTitle) =>
      "Restaurants/$restaurantTitle";

  static String restaurantOrders(Reservation reservation, String uid) =>
      "Restaurants/${reservation.restaurant}/Table ${reservation.selectedTable}/$uid - ${reservation.date}";
}
