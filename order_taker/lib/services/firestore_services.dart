import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/models/restaurant_info_model.dart';
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
    final userReservationRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Reservations');
    final restaurantReservationRef = FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(title)
        .collection("Reservations");
    restaurantReservationRef.get().then((value) => {
          for (DocumentSnapshot doc in value.docs)
            {
              if (doc.data() != date)
                {
                  restaurantReservationRef.doc(doc.id).set({"Resrvation": date})
                }
            }
        });

    userReservationRef.get().then((value) => userReservationRef
        .doc(value.docs.length.toString())
        .set({"title": title, "date": date, "imagepath": imagePath}));
  }

  Future<void> deleteReservation(String uid, String id) async {
    final reservationRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Reservations');

    await reservationRef.doc(id).delete();
  }

  Future<RestaurantInformation> fetchRestaurantInfo(String restaurant) async {
    final reservationRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(restaurant);

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
}
