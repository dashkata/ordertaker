class FirestorePath {
  static String restaurants() => "Restaurants";

  static String userReservations(String uid) => "Users/$uid/Reservations";

  static String restaurantReservations(String restaurantTitle) =>
      "Restaurants/$restaurantTitle/Reservations";

  static String user(String uid) => "Users/$uid";

  static String restaurant(String restaurantTitle) =>
      "Restaurants/$restaurantTitle";

  static String restaurantOrders(String restaurantName, String table) =>
      "Restaurants/$restaurantName/Tables/$table";
}
