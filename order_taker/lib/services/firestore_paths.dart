class FirestorePath {
  static String restaurants() => "Restaurants";

  static String userReservations(String uid) => "Users/$uid/Reservations";

  static String restaurantReservations(String restaurantTitle) =>
      "Users/$restaurantTitle/Reservations";

  static String user(String uid) => "Users/$uid";

  static String restaurant(String restaurantTitle) =>
      "Restaurants/$restaurantTitle";
}
