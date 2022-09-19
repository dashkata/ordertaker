import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/order_model.dart';
import '../models/reservation_model.dart';
import '../models/restaurant_info_model.dart';
import '../models/restaurant_model.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';
import 'firestore_paths.dart';

class FirestoreRepository {
  Stream<List<Restaurant>> fetchRestaurants() {
    final restaurantRef =
        FirebaseFirestore.instance.collection(FirestorePath.restaurants());
    final restaurantSnapshot = restaurantRef.snapshots();

    return restaurantSnapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs
          .map(
            (restaurant) =>
                Restaurant.fromMap(restaurant.data() as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Stream<List<Reservation>> fetchReservations(String uid) {
    final reservationsSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid))
        .snapshots();
    return reservationsSnapshot.map(
      (reservations) => reservations.docs
          .map((reservation) => Reservation.fromMap(reservation.data()))
          .toList(),
    );
  }

  void addReservation(String uid, Reservation reservation) {
    final userReservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
      FirestorePath.restaurantReservations(
        reservation.restaurant,
        reservation.selectedTable,
      ),
    );
    restaurantReservationRef.get().then(
          (value) => restaurantReservationRef
              .doc('$uid - ${reservation.date}')
              .set(reservation.toMap()),
        );
    userReservationRef.get().then(
          (value) => userReservationRef
              .doc('${reservation.restaurant} - ${reservation.date}')
              .set(reservation.toMap()),
        );
  }

  Future<void> deleteReservation(String uid, Reservation reservation) async {
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
      FirestorePath.restaurantReservations(
        reservation.restaurant,
        reservation.selectedTable,
      ),
    );
    await restaurantReservationRef.doc('$uid - ${reservation.date}').delete();

    final reservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    await reservationRef
        .doc('${reservation.restaurant} - ${reservation.date}')
        .delete();
  }

  Future<String> fetchMobileNumber(String uid) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    return userCollection.get().then((value) => value['Mobile Number']);
  }

  Future<String> setMobileNumber(String uid, String mobileNumber) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    await userCollection.set(
      {
        'Mobile Number': mobileNumber,
      },
      SetOptions(merge: true),
    );
    return 'Mobile number changed successfully';
  }

  Future<RestaurantInformation> fetchRestaurantInfo(String restaurant) async {
    final reservationRef =
        FirebaseFirestore.instance.doc(FirestorePath.restaurant(restaurant));

    return reservationRef.get().then(
          (restaurantInfo) => RestaurantInformation(
            title: restaurantInfo['title'],
            overview: restaurantInfo['overview'],
            openhours: restaurantInfo['openhours'],
            paymentOptions: restaurantInfo['paymentOptions'],
            phoneNumber: restaurantInfo['phoneNumber'],
            location: restaurantInfo['location'],
          ),
        );
  }

  Future<void> setUserType(String type, String uid) async {
    final userRef = FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    await userRef.set({'type': type}, SetOptions(merge: true));
  }

  Future<String> fetchUserType(String uid) async {
    final userRef =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return userRef.get('type');
  }

  Future<void> setRestaurantName(String restaurantName) async {
    FirebaseFirestore.instance
        .collection(FirestorePath.restaurants())
        .doc(restaurantName);
  }

  Future<CustomUser> fetchCurrentUser(AuthRepository authRepository) async {
    final User? user = authRepository.getCurrentUser();
    final mobileNumber = await fetchMobileNumber(user!.uid);
    return CustomUser(
      uid: user.uid,
      username: user.displayName!,
      email: user.email!,
      mobileNumber: mobileNumber,
    );
  }

  Future<void> completeOrder(
    Order orders,
    String uid,
    Reservation reservation,
  ) async {
    final ordersRef = FirebaseFirestore.instance.collection(
      FirestorePath.restaurantOrders(reservation, uid),
    );
    await ordersRef.get().then(
          (value) async =>
              await ordersRef.doc('order ${value.docs.length + 1}').set(
            {
              'order': orders.ordersToList(),
              'time_stamp': DateTime.now(),
            },
            SetOptions(merge: true),
          ),
        );
  }

  // Future<List<Order>> fetchOrdersUser(
  //   Reservation reservation,
  //   String uid,
  // ) async {
  //   final orderRef = await FirebaseFirestore.instance
  //       .doc(FirestorePath.restaurantOrders(reservation, uid))
  //       .get();
  //   // final List<Order> orders = [];
  //   // if (orderRef.data()?.keys != null) {
  //   //   for (final field in orderRef.data()!.keys) {
  //   //     if (field.contains('order')) {
  //   //       orders.add(
  //   //         Order.fromMap(
  //   //           orderRef.get(field),
  //   //         ),
  //   //       );
  //   //     }
  //   //   }
  //   // }
  //   // return orders;
  // }

  Stream<List<Order>> fetchOrdersRestaurant(
    String tableId,
    String restaurant,
  ) async* {
    final tablesRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTable(tableId, restaurant))
        .where('currentOrder', isEqualTo: true)
        .limit(1)
        .get();
    final ordersCollection =
        tablesRef.docs[0].reference.collection('Orders').snapshots();

    yield* ordersCollection.map(
      (tables) => tables.docs
          .map((table) => Order.fromMap(table['order'] as List<dynamic>))
          .toList(),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenForOrders(
      String restaurantTitle, String tableId) async* {
    final tablerRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTable(tableId, restaurantTitle))
        .where('currentOrder', isEqualTo: true)
        .get();
    yield* tablerRef.docs[0].reference
        .collection('Orders')
        .where('time_stamp', isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();
  }
}
