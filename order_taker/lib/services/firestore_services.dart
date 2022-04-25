import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/models/restaurant_model.dart';

class DatabaseService {
  Stream<List<Restaurant>> fetchRestaurants() {
    final restaurantRef = FirebaseFirestore.instance.collection('Restaurants');

    final restaurantSnapshot = restaurantRef.snapshots();
    return restaurantSnapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs
          .map(
            (restaurant) => Restaurant(
              title: restaurant["title"],
              desc: restaurant["description"],
              imagepath: restaurant["imagepath"],
            ),
          )
          .toList(),
    );
  }

  Stream<List<Reservation>> fetchReservations(String uid) {
    final reservationRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Reservations');

    final reservationsSnapshot = reservationRef.snapshots();
    return reservationsSnapshot.map((QuerySnapshot querySnapshot) =>
        querySnapshot.docs
            .map((order) => Reservation(
                id: order.id,
                restaurant: order["title"],
                date: order["date"],
                imagepath: order["imagepath"]))
            .toList());
  }

  void addReservation(String uid, String title, String date, String imagePath) {
    final reservationRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Reservations');
    reservationRef.get().then((value) => reservationRef
        .doc(value.docs.length.toString())
        .set({"title": title, "date": date, "imagepath": imagePath}));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchRestaurantInfo(
      String restaurantTitle) {
    return FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurantTitle)
        .snapshots();
  }

  // void updateReservations(String uid){
  //   final reservationRef = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(uid)
  //       .collection('Reservations').get();
  //   for(DocumentReference doc in reservationRef.)

  // }

  Future<void> deleteReservation(String uid, String id) async {
    final reservationRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Reservations');

    await reservationRef.doc(id).delete();
  }

  // }
}
