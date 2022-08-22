import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_taker/models/order_model.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/models/restaurant_info_model.dart';
import 'package:order_taker/models/restaurant_model.dart';
import 'package:order_taker/repositories/auth_repository.dart';

import '../models/user_model.dart';
import 'firestore_paths.dart';

class FirestoreRepository {
  Stream<List<Restaurant>> fetchRestaurants() {
    final restaurantRef =
        FirebaseFirestore.instance.collection(FirestorePath.restaurants());
    final restaurantSnapshot = restaurantRef.snapshots();

    return restaurantSnapshot.map((QuerySnapshot querySnapshot) => querySnapshot
        .docs
        .map((restaurant) =>
            Restaurant.fromMap(restaurant.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Reservation>> fetchReservations(String uid) {
    final reservationsSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid))
        .snapshots();
    return reservationsSnapshot.map((reservations) => reservations.docs
        .map((reservation) => Reservation.fromMap(reservation.data()))
        .toList());
  }

  void addReservation(String uid, Reservation reservation) {
    final userReservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
        FirestorePath.restaurantReservations(reservation.restaurant));
    restaurantReservationRef.get().then((value) => restaurantReservationRef
        .doc('$uid - ${reservation.date}')
        .set(reservation.toMap()));
    userReservationRef.get().then((value) => userReservationRef
        .doc('${reservation.restaurant} - ${reservation.date}')
        .set(reservation.toMap()));
  }

  Future<void> deleteReservation(String uid, Reservation reservation) async {
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
        FirestorePath.restaurantReservations(reservation.restaurant));
    restaurantReservationRef.doc('$uid - ${reservation.date}').delete();

    final reservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    await reservationRef
        .doc('${reservation.restaurant} - ${reservation.date}')
        .delete();
  }

  Future<String> fetchMobileNumber(String uid) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    return userCollection.get().then((value) => value["Mobile Number"]);
  }

  Future<String> setMobileNumber(String uid, String mobileNumber) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    userCollection.set({
      "Mobile Number": mobileNumber,
    }, SetOptions(merge: true));
    return "Mobile number changed successfully";
  }

  Future<RestaurantInformation> fetchRestaurantInfo(String restaurant) async {
    final reservationRef =
        FirebaseFirestore.instance.doc(FirestorePath.restaurant(restaurant));

    return reservationRef.get().then(
          (restaurantInfo) => RestaurantInformation(
              title: restaurantInfo["title"],
              overview: restaurantInfo["overview"],
              openhours: restaurantInfo["openhours"],
              paymentOptions: restaurantInfo["paymentOptions"],
              phoneNumber: restaurantInfo["phoneNumber"],
              location: restaurantInfo["location"]),
        );
  }

  Future<void> setUserType(String type, String uid) async {
    final userRef = FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    await userRef.set({"type": type}, SetOptions(merge: true));
  }

  Future<String> fetchUserType(String uid) async {
    final userRef =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return userRef.get("type");
  }

  Future<void> setRestaurantName(String restaurantName) async {
    final restuarantRef =
        FirebaseFirestore.instance.collection(FirestorePath.restaurants());
    restuarantRef.doc(restaurantName);
  }

  Future<CustomUser> fetchCurrentUser(AuthRepository authRepository) async {
    User? user = authRepository.getCurrentUser();
    final mobileNumber = await fetchMobileNumber(user!.uid);
    return CustomUser(
        uid: user.uid,
        username: user.displayName!,
        email: user.email!,
        mobileNumber: mobileNumber);
  }

  Future<void> completeOrder(
      String restaurantName, String table, Order orders) async {
    final tableRef = FirebaseFirestore.instance.doc(
      FirestorePath.restaurantOrders(restaurantName, table),
    );
    final tableSnapshot = await tableRef.get();

    int orderCount = 1;
    if (tableSnapshot.data()?.length != null) {
      orderCount = tableSnapshot.data()!.length + 1;
    }
    await tableRef.set(
      {
        'order $orderCount': orders.ordersToList(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
