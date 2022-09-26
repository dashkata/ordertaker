import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Stream<List<Reservation>> fetchRestaurantReservations(
    String restaurantTitle,
    int tableId,
  ) {
    final reservationSnapshot = FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTable(
            tableId.toString(),
            restaurantTitle,
          ),
        )
        .snapshots();
    return reservationSnapshot.map(
      (reservations) => reservations.docs
          .map((reservation) => Reservation.fromMap(reservation.data()))
          .toList(),
    );
  }

  Future<bool> checkForCurrentReservation(
    String restaurantTitle,
    int tableId,
  ) async {
    final restaurantRef = await FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTable(
            tableId.toString(),
            restaurantTitle,
          ),
        )
        .where('currentReservation', isEqualTo: true)
        .limit(1)
        .get();
    return restaurantRef.docs.isEmpty;
  }

  Future<void> setCurrentReservation(
      String restaurantTitle, int tableId, Reservation reservation) async {
    final reservationRef = await FirebaseFirestore.instance
        .collection(
            FirestorePath.restaurantTable(tableId.toString(), restaurantTitle))
        .where(
          'personName',
          isEqualTo: reservation.name,
        )
        .where(
          'reservationDate',
          isEqualTo: reservation.date,
        )
        .get();
    await reservationRef.docs[0].reference.set(
      {'currentReservation': true},
      SetOptions(merge: true),
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
    if (orders.menuItems.isNotEmpty) {
      final ordersRef = FirebaseFirestore.instance.collection(
        FirestorePath.restaurantOrders(reservation, uid),
      );
      await ordersRef.get().then(
            (value) async =>
                await ordersRef.doc('order ${value.docs.length + 1}').set(
              {
                'id': value.docs.length,
                'order': orders.ordersToList(),
                'timeStamp': DateTime.now(),
                'status': 'new'
              },
              SetOptions(merge: true),
            ),
          );
    }
  }

  Stream<List<Order>> fetchOrdersUser(
    Reservation reservation,
    String uid,
  ) {
    final orderRef = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantOrders(reservation, uid))
        .snapshots();
    return orderRef.map(
      (orders) => orders.docs
          .map(
            (order) => Order.fromMap(
              order['order'],
              order['id'],
              order['status'],
            ),
          )
          .toList(),
    );
  }

  Stream<List<Order>> fetchOrdersRestaurant(
    String tableId,
    String restaurant,
  ) async* {
    final currentReservationRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTable(tableId, restaurant))
        .where('currentReservation', isEqualTo: true)
        .limit(1)
        .get();
    final ordersCollection = currentReservationRef.docs[0].reference
        .collection('Orders')
        .snapshots();

    yield* ordersCollection.map(
      (orders) => orders.docs
          .map(
            (order) => Order.fromMap(
              order['order'],
              order['id'],
              order['status'],
            ),
          )
          .toList(),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenForOrders(
      String restaurantTitle, String tableId) async* {
    final tablerRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTable(tableId, restaurantTitle))
        .where('currentReservation', isEqualTo: true)
        .get();
    yield* tablerRef.docs[0].reference
        .collection('Orders')
        .where('timeStamp', isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();
  }

  Future<void> updateOrderStatus(
    int id,
    String orderStatus,
    String tableId,
    String restaurantTitle,
  ) async {
    final currentReservationRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTable(tableId, restaurantTitle))
        .where('currentReservation', isEqualTo: true)
        .limit(1)
        .get();
    final ordersCollection = await currentReservationRef.docs[0].reference
        .collection('Orders')
        .where('id', isEqualTo: id)
        .get();
    await ordersCollection.docs[0].reference.set(
      {'status': orderStatus},
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<List<String>> fetchFreeTables(
      String restaurantTitle, String date) async {
    final tableRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTables('Pizza Don Vito'))
        .get();
    final List<String> freeTables = [];
    for (int i = 0; i < tableRef.docs.length; i++) {
      final reservationRef = await tableRef.docs[i].reference
          .collection('Reservations')
          .where('reservationDate', isEqualTo: date)
          .get();
      if (reservationRef.docs.isEmpty) {
        freeTables.add(tableRef.docs[i].id);
      }
    }
    return freeTables;
  }
}
