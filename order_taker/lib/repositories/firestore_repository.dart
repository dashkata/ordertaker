import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../models/menu_item_model.dart';
import '../models/menu_section_model.dart';
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
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return userCollection.get('phoneNumber');
  }

  Future<String> setMobileNumber(String uid, String mobileNumber) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    await userCollection.set(
      {
        'phoneNumber': mobileNumber,
      },
      SetOptions(merge: true),
    );
    return 'Mobile number changed successfully';
  }

  Future<Restaurant> fetchRestaurantInfo(String restaurant) async {
    final reservationRef =
        FirebaseFirestore.instance.doc(FirestorePath.restaurant(restaurant));

    return reservationRef.get().then(
          (restaurantInfo) => Restaurant.fromMap(restaurantInfo.data() ?? {}),
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

  Future<bool> fetchOnBoarding(String uid) async {
    final userRef =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return userRef.get('onBoarding');
  }

  Future<void> setRestaurantTitle(String restaurantName, String uid) async {
    await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).set(
      {
        'restaurant': restaurantName,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> setOnBoarding(String uid, {required bool onBoarding}) async {
    await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).set(
      {
        'onBoarding': onBoarding,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<String> fetchRestaurantTitle(String uid) async {
    final doc =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return doc.get('restaurant');
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
                'status': 'new',
                'additionalMessage': orders.additionalMessage,
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
              order['additionalMessage'],
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
              order['additionalMessage'],
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

  Future<Map<String, bool>> fetchFreeTables(
      String restaurantTitle, String date) async {
    final tableRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTables(restaurantTitle))
        .get();
    final Map<String, bool> freeTables = {};
    for (int i = 0; i < tableRef.docs.length; i++) {
      final reservationRef = await tableRef.docs[i].reference
          .collection('Reservations')
          .where('reservationDate', isEqualTo: date)
          .get();
      if (reservationRef.docs.isEmpty) {
        freeTables[tableRef.docs[i].id] = true;
      } else {
        freeTables[tableRef.docs[i].id] = false;
      }
    }
    return freeTables;
  }

  Future<void> submitRestaurantDetails(
    Restaurant restaurant,
    int insideTables,
    int outsideTables,
  ) async {
    await FirebaseFirestore.instance
        .doc(FirestorePath.restaurant(restaurant.title))
        .set(
          restaurant.restaurantToMap(),
        );
    // for (int i = 0; i < insideTables; i++) {
    //   await FirebaseFirestore.instance
    //       .doc(FirestorePath.restaurantTable(i.toString(), restaurant.title))
    //       .set({
    //     'location': 'inside',
    //   });
    // }
    // for (int i = 0; i < outsideTables; i++) {
    //   await FirebaseFirestore.instance
    //       .doc(FirestorePath.restaurantTable(i.toString(), restaurant.title))
    //       .set({
    //     'location': 'outside',
    //   });
    // }
  }

  Future<void> addMenuItem(OrderItem orderItem, String restaurant) async {
    await FirebaseFirestore.instance
        .doc(FirestorePath.restaurantMenuType(restaurant, orderItem.itemType))
        .set(
      {
        orderItem.itemType: {
          orderItem.itemTitle: orderItem.orderItemToMap(),
        }
      },
      SetOptions(merge: true),
    );
  }

  Stream<List<MenuSection>> fetchMenu(String title) {
    final menuSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantMenu(title))
        .snapshots();
    return menuSnapshot.map(
      (snapshot) => snapshot.docs
          .map(
            (item) => MenuSection.fromMap(
              item.data(),
              item.id,
            ),
          )
          .toList(),
    );
  }

  Future<List<String>> fetchTables(String restaurantTitle) async {
    final List<String> tables = [];
    final tableRef = await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantTables(restaurantTitle))
        .get();
    for (final table in tableRef.docs) {
      tables.add(table.id);
    }
    return tables;
  }

  Future<bool> checkUserReservation(Reservation reservation, String uid) async {
    final reservationRef = await FirebaseFirestore.instance
        .doc(
          '${FirestorePath.restaurantReservations(reservation.restaurant, reservation.selectedTable)}/$uid - ${reservation.date}',
        )
        .get();
    if (reservationRef.data() != null &&
        reservationRef.data()!.containsKey('currentReservation')) {
      return true;
    }
    return false;
  }

  Future<void> changeMenuItemStatus({
    required bool status,
    required String restaurantTitle,
    required OrderItem item,
  }) async {
    await FirebaseFirestore.instance
        .doc(FirestorePath.restaurantMenuType(restaurantTitle, item.itemType))
        .update(
      {
        '${item.itemType}.${item.itemTitle}.available': status,
      },
    );
  }
}
