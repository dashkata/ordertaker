import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/data/entities/menu_item_entity.dart';
import 'package:order_taker/data/entities/menu_section_entity.dart';
import 'package:order_taker/data/entities/order_entity.dart';
import 'package:order_taker/data/entities/reservation_entity.dart';
import 'package:order_taker/data/entities/restaurant_entity.dart';
import 'package:order_taker/data/entities/review_entity.dart';

import '../repositories/firestore_paths.dart';

class API {
  final database = FirebaseFirestore.instance;

  //Queries for restaurans
  Stream<List<RestaurantEntity>> fetchRestaurants() {
    final restaurantRef = database.collection(FirestorePath.restaurants());
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
    final reservationRef = database.doc(FirestorePath.restaurant(restaurant));

    return reservationRef.get().then(
          (restaurantInfo) =>
              RestaurantEntity.fromMap(restaurantInfo.data() ?? {}),
        );
  }

  Future<void> setRestaurantTitle(String restaurantName, String uid) async {
    await database.doc(FirestorePath.user(uid)).set(
      {
        'restaurant': restaurantName,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<String> fetchRestaurantTitle(String uid) async {
    final doc = await database.doc(FirestorePath.user(uid)).get();
    return doc.get('restaurant');
  }

  Future<void> submitRestaurantDetails(
    RestaurantEntity restaurant,
    int tables,
  ) async {
    await database.doc(FirestorePath.restaurant(restaurant.title)).set(
          restaurant.toMap(),
        );
    for (int i = 1; i <= tables; i++) {
      await database
          .doc(FirestorePath.restaurantTable(i.toString(), restaurant.title))
          .set({
        'id': i,
      });
    }
  }

  Future<void> setRestaurantEmail(String email, String uid) async {
    await database.doc(FirestorePath.user(uid)).set(
      {
        'restaurant_email': email,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<String?> getRestauarntEmail(String uid) async {
    final adminRef = await database.doc(FirestorePath.user(uid)).get();
    if (adminRef.data()!.containsKey('restaurant_email')) {
      return adminRef.get('restaurant_email');
    } else {
      return null;
    }
  }

  Future<void> updateRestaurantInformation(
    String updatedInfo,
    String restaurantTitle,
    String detailType,
  ) async {
    await database
        .doc(
      FirestorePath.restaurant(restaurantTitle),
    )
        .update({
      detailType: updatedInfo,
    });
  }

  //Queries for reservations

  Stream<List<ReservationEntity>> fetchReservations(String uid) {
    final reservationsSnapshot =
        database.collection(FirestorePath.userReservations(uid)).snapshots();
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
    final reservationSnapshot = database
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
    final restaurantRef = await database
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
    final reservationRef = await database
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
    final userReservationRef =
        database.collection(FirestorePath.userReservations(uid));
    final restaurantReservationRef = database.collection(
      FirestorePath.restaurantRequests(
        reservation.restaurant.title,
      ),
    );
    await userReservationRef
        .doc('${reservation.restaurant.title} - ${reservation.date}')
        .set(reservation.toMap());

    await restaurantReservationRef
        .doc('$uid - ${reservation.date}')
        .set(reservation.toMap());
  }

  Future<void> deleteReservation(
    String uid,
    ReservationEntity reservation,
  ) async {
    if (reservation.table != null) {
      final restaurantReservationRef = database.collection(
        FirestorePath.restaurantReservations(
          reservation.restaurant.title,
          reservation.table!,
        ),
      );
      await restaurantReservationRef.doc('$uid - ${reservation.date}').delete();
    }

    await database
        .doc(
          FirestorePath.restaurantRequest(
            reservation.restaurant.title,
            reservation.userId,
            reservation.date,
          ),
        )
        .delete();
    final reservationRef =
        database.collection(FirestorePath.userReservations(uid));
    await reservationRef
        .doc('${reservation.restaurant.title} - ${reservation.date}')
        .delete();
  }

  Future<bool> checkUserReservation(
      ReservationEntity reservation, String uid) async {
    final reservationRef = await database
        .doc(
          '${FirestorePath.restaurantReservations(reservation.restaurant.title, reservation.table!)}/$uid - ${reservation.date}',
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
      await database
          .doc(
        FirestorePath.restaurantTable(
          reservation.table!.toString(),
          reservation.restaurant.title,
        ),
      )
          .set(
        {
          'empty': '',
        },
      );
      await database
          .doc(
            FirestorePath.userReservation(
              reservation.userId,
              reservation.restaurant.title,
              reservation.date,
            ),
          )
          .set(
            reservation.toMap(),
          );
      await database
          .doc(
            FirestorePath.restaurantRequest(
              reservation.restaurant.title,
              reservation.userId,
              reservation.date,
            ),
          )
          .delete();
      await database
          .collection(
            FirestorePath.restaurantReservations(
              reservation.restaurant.title,
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
    final userCollection = await database.doc(FirestorePath.user(uid)).get();
    return userCollection.get('phoneNumber');
  }

  Future<String> setMobileNumber(String uid, String mobileNumber) async {
    final userCollection = database.doc(FirestorePath.user(uid));
    await userCollection.set(
      {
        'phoneNumber': mobileNumber,
      },
      SetOptions(merge: true),
    );
    return 'Mobile number changed successfully';
  }

  Future<void> setUserType(String type, String uid) async {
    final userRef = database.doc(FirestorePath.user(uid));
    await userRef.set({'type': type}, SetOptions(merge: true));
  }

  Future<String> fetchUserType(String uid) async {
    final userRef = await database.doc(FirestorePath.user(uid)).get();
    print(userRef.get('type'));
    return userRef.get('type');
  }

  Future<bool> fetchOnBoarding(String uid) async {
    final userRef = await database.doc(FirestorePath.user(uid)).get();
    return userRef.get('onBoarding');
  }

  Future<void> setOnBoarding(String uid, {required bool onBoarding}) async {
    await database.doc(FirestorePath.user(uid)).set(
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
    UserOrderEntity orders,
    String uid,
    ReservationEntity reservation,
  ) async {
    if (orders.menuItems.isNotEmpty) {
      final ordersRef = database.collection(
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

  Stream<List<UserOrderEntity>> fetchOrdersUser(
    ReservationEntity reservation,
    String uid,
  ) {
    final orderRef = database
        .collection(FirestorePath.restaurantOrders(reservation, uid))
        .snapshots();
    return orderRef.map(
      (orders) => orders.docs
          .map(
            (order) => UserOrderEntity.fromMap(
              order['order'],
              order['id'],
              order['status'],
              order['additionalMessage'],
            ),
          )
          .toList(),
    );
  }

  Stream<List<UserOrderEntity>> fetchOrdersRestaurant(
    String tableId,
    String restaurant,
  ) async* {
    final currentReservationRef = await database
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
            (order) => UserOrderEntity.fromMap(
              order['order'],
              order['id'],
              order['status'],
              order['additionalMessage'],
            ),
          )
          .toList(),
    );
  }

  Future<void> updateOrderStatus(
    int id,
    String orderStatus,
    String tableId,
    String restaurantTitle,
  ) async {
    final currentReservationRef = await database
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
    final tableRef = await database
        .collection(FirestorePath.restaurantTables(restaurantTitle))
        .get();
    for (final table in tableRef.docs) {
      tables.add(table.id);
    }
    return tables;
  }

  //Queries for menu

  Future<void> addMenuItem(OrderItemEntity orderItem, String restaurant) async {
    await database
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

  Stream<List<MenuSectionEntity>> fetchMenu(String title) {
    final menuSnapshot =
        database.collection(FirestorePath.restaurantMenu(title)).snapshots();
    return menuSnapshot.map(
      (snapshot) => snapshot.docs
          .map(
            (item) => MenuSectionEntity.fromMap(
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
    required OrderItemEntity item,
  }) async {
    await database
        .doc(FirestorePath.restaurantMenuType(restaurantTitle, item.itemType))
        .update(
      {
        '${item.itemType}.${item.itemTitle}.available': status,
      },
    );
  }

  Future<void> removeMenuItem({
    required OrderItemEntity item,
    required String restaurantTitle,
  }) async {
    await database
        .doc(FirestorePath.restaurantMenuType(restaurantTitle, item.itemType))
        .update({
      '${item.itemType}.${item.itemTitle}': FieldValue.delete(),
    });
  }

  //Queries for reviews

  Stream<List<ReviewEntity>> fetchReviews(String restaurantTitle) {
    final reviewSnapshot = database
        .collection(FirestorePath.restaurantReviews(restaurantTitle))
        .snapshots();
    return reviewSnapshot.map(
      (snapshot) => snapshot.docs
          .map(
            (review) => ReviewEntity.fromMap(
              data: review.data(),
            ),
          )
          .toList(),
    );
  }

  Future<void> addRestaurantReview(
    String restaurantTitle,
    ReviewEntity review,
  ) async {
    await database
        .collection(FirestorePath.restaurantReviews(restaurantTitle))
        .add(
          review.toMap(),
        );
  }

  Stream<List<ReservationEntity>> fetchRestaurantRequests(
    String restaurantTitle,
  ) {
    final requestsSnapshot = database
        .collection(FirestorePath.restaurantRequests(restaurantTitle))
        .snapshots();

    return requestsSnapshot.map(
      (requests) => requests.docs
          .map((request) => ReservationEntity.fromMap(request.data()))
          .toList(),
    );
  }

  //Queries for requests
  Future<void> disapproveRequest(ReservationEntity reservation) async {
    await database
        .doc(
          FirestorePath.restaurantRequest(
            reservation.restaurant.title,
            reservation.userId,
            reservation.date,
          ),
        )
        .delete();
    await database
        .doc(
          FirestorePath.userReservation(
            reservation.userId,
            reservation.restaurant.title,
            reservation.date,
          ),
        )
        .delete();
  }
}
