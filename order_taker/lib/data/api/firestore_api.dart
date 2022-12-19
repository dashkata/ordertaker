import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/data/entities/reservation_entity.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/models/review_model.dart';

import '../repositories/firestore_paths.dart';

class API {
  //Queries for restaurans
  Stream<List<RestaurantEntity>> fetchRestaurants() {
    final restaurantRef =
        FirebaseFirestore.instance.collection(FirestorePath.restaurants());
    final restaurantSnapshot = restaurantRef.snapshots();

    return restaurantSnapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs
          .map(
            (restaurant) => RestaurantEntity.fromMap(
              restaurant.data() as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Future<RestaurantEntity> fetchRestaurantInfo(String restaurant) async {
    final reservationRef =
        FirebaseFirestore.instance.doc(FirestorePath.restaurant(restaurant));

    return reservationRef.get().then(
          (restaurantInfo) =>
              RestaurantEntity.fromMap(restaurantInfo.data() ?? {}),
        );
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

  Future<String> fetchRestaurantTitle(String uid) async {
    final doc =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return doc.get('restaurant');
  }

  Future<void> submitRestaurantDetails(
    RestaurantEntity restaurant,
    int tables,
  ) async {
    await FirebaseFirestore.instance
        .doc(FirestorePath.restaurant(restaurant.title))
        .set(
          restaurant.toMap(),
        );
    for (int i = 1; i <= tables; i++) {
      await FirebaseFirestore.instance
          .doc(FirestorePath.restaurantTable(i.toString(), restaurant.title))
          .set({
        'id': i,
      });
    }
  }

  Future<void> setRestaurantEmail(String email, String uid) async {
    await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).set(
      {
        'restaurant_email': email,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<String?> getRestauarntEmail(String uid) async {
    final adminRef =
        await FirebaseFirestore.instance.doc(FirestorePath.user(uid)).get();
    return adminRef.get('restaurant_email');
  }

  Future<void> updateRestaurantInformation(
    String updatedInfo,
    String restaurantTitle,
    String detailType,
  ) async {
    await FirebaseFirestore.instance
        .doc(
      FirestorePath.restaurant(restaurantTitle),
    )
        .update({
      detailType: updatedInfo,
    });
  }

  //Queries for reservations

  Stream<List<ReservationEntity>> fetchReservations(String uid) {
    final reservationsSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid))
        .snapshots();
    return reservationsSnapshot.map(
      (reservations) => reservations.docs
          .map((reservation) => ReservationEntity.fromMap(reservation.data()))
          .toList(),
    );
  }

  Stream<List<ReservationEntity>> fetchRestaurantReservations(
    String restaurantTitle,
    int tableId,
  ) {
    final reservationSnapshot = FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTableReservations(
            tableId.toString(),
            restaurantTitle,
          ),
        )
        .snapshots();
    return reservationSnapshot.map(
      (reservations) => reservations.docs
          .map((reservation) => ReservationEntity.fromMap(reservation.data()))
          .toList(),
    );
  }

  Future<bool> checkForCurrentReservation(
    String restaurantTitle,
    int tableId,
  ) async {
    final restaurantRef = await FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTableReservations(
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
    String restaurantTitle,
    int tableId,
    ReservationEntity reservation,
  ) async {
    final reservationRef = await FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTableReservations(
            tableId.toString(),
            restaurantTitle,
          ),
        )
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

  Future<void> addReservation(String uid, ReservationEntity reservation) async {
    final userReservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
      FirestorePath.restaurantRequests(
        reservation.restaurant,
      ),
    );
    await userReservationRef
        .doc('${reservation.restaurant} - ${reservation.date}')
        .set(reservation.toMap());

    await restaurantReservationRef
        .doc('$uid - ${reservation.date}')
        .set(reservation.toMap());
  }

  Future<void> deleteReservation(
      String uid, ReservationEntity reservation) async {
    final restaurantReservationRef = FirebaseFirestore.instance.collection(
      FirestorePath.restaurantReservations(
        reservation.restaurant,
        reservation.table!,
      ),
    );
    await restaurantReservationRef.doc('$uid - ${reservation.date}').delete();
    await FirebaseFirestore.instance
        .doc(
          FirestorePath.restaurantRequest(
            reservation.restaurant,
            reservation.userId,
            reservation.date,
          ),
        )
        .delete();

    final reservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    await reservationRef
        .doc('${reservation.restaurant} - ${reservation.date}')
        .delete();
  }

  Future<bool> checkUserReservation(
      ReservationEntity reservation, String uid) async {
    final reservationRef = await FirebaseFirestore.instance
        .doc(
          '${FirestorePath.restaurantReservations(reservation.restaurant, reservation.table!)}/$uid - ${reservation.date}',
        )
        .get();
    if (reservationRef.data() != null &&
        reservationRef.data()!.containsKey('currentReservation')) {
      return true;
    }
    return false;
  }

  Future<void> addApprovedReservation(ReservationEntity reservation) async {
    if (reservation.table != null) {
      await FirebaseFirestore.instance
          .doc(
        FirestorePath.restaurantTable(
          reservation.table!.toString(),
          reservation.restaurant,
        ),
      )
          .set(
        {
          'empty': '',
        },
      );
      await FirebaseFirestore.instance
          .doc(
            FirestorePath.userReservation(
              reservation.userId,
              reservation.restaurant,
              reservation.date,
            ),
          )
          .set(
            reservation.toMap(),
          );
      await FirebaseFirestore.instance
          .doc(
            FirestorePath.restaurantRequest(
              reservation.restaurant,
              reservation.userId,
              reservation.date,
            ),
          )
          .delete();
      await FirebaseFirestore.instance
          .collection(
            FirestorePath.restaurantReservations(
              reservation.restaurant,
              reservation.table!,
            ),
          )
          .doc(
            '${reservation.userId} - ${reservation.date}',
          )
          .set(
            reservation.toMap(),
          );
    }
  }

  //Queries for users
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

  //Queries for orders

  Future<void> completeOrder(
    UserOrder orders,
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

  Stream<List<UserOrder>> fetchOrdersUser(
    Reservation reservation,
    String uid,
  ) {
    final orderRef = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantOrders(reservation, uid))
        .snapshots();
    return orderRef.map(
      (orders) => orders.docs
          .map(
            (order) => UserOrder.fromMap(
              order['order'],
              order['id'],
              order['status'],
              order['additionalMessage'],
            ),
          )
          .toList(),
    );
  }

  Stream<List<UserOrder>> fetchOrdersRestaurant(
    String tableId,
    String restaurant,
  ) async* {
    final currentReservationRef = await FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTableReservations(tableId, restaurant),
        )
        .where('currentReservation', isEqualTo: true)
        .limit(1)
        .get();
    final ordersCollection = currentReservationRef.docs[0].reference
        .collection('Orders')
        .snapshots();

    yield* ordersCollection.map(
      (orders) => orders.docs
          .map(
            (order) => UserOrder.fromMap(
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
    String restaurantTitle,
    String tableId,
  ) async* {
    final tablerRef = await FirebaseFirestore.instance
        .collection(
          FirestorePath.restaurantTableReservations(tableId, restaurantTitle),
        )
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
        .collection(
          FirestorePath.restaurantTableReservations(tableId, restaurantTitle),
        )
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

  //Queries for tables

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

  //Queries for menu

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

  Future<void> removeMenuItem({
    required OrderItem item,
    required String restaurantTitle,
  }) async {
    await FirebaseFirestore.instance
        .doc(FirestorePath.restaurantMenuType(restaurantTitle, item.itemType))
        .update({
      '${item.itemType}.${item.itemTitle}': FieldValue.delete(),
    });
  }

  //Queries for reviews

  Stream<List<Review>> fetchReviews(String restaurantTitle) {
    final reviewSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantReviews(restaurantTitle))
        .snapshots();
    return reviewSnapshot.map(
      (snapshot) => snapshot.docs
          .map(
            (review) => Review.fromMap(
              data: review.data(),
            ),
          )
          .toList(),
    );
  }

  Future<void> addRestaurantReview(
    String restaurantTitle,
    Review review,
  ) async {
    await FirebaseFirestore.instance
        .collection(FirestorePath.restaurantReviews(restaurantTitle))
        .add(
          review.toMap(),
        );
  }

  Stream<List<Reservation>> fetchRestaurantRequests(
    String restaurantTitle,
  ) {
    final requestsSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantRequests(restaurantTitle))
        .snapshots();

    return requestsSnapshot.map(
      (requests) => requests.docs
          .map((request) => Reservation.fromMap(request.data()))
          .toList(),
    );
  }

  //Queries for requests
  Future<void> disapproveRequest(Reservation reservation) async {
    await FirebaseFirestore.instance
        .doc(
          FirestorePath.restaurantRequest(
            reservation.restaurant,
            reservation.userId,
            reservation.date,
          ),
        )
        .delete();
    await FirebaseFirestore.instance
        .doc(
          FirestorePath.userReservation(
            reservation.userId,
            reservation.restaurant,
            reservation.date,
          ),
        )
        .delete();
  }
}
