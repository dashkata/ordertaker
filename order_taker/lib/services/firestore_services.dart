import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/models/restaurant_info_model.dart';
import 'package:order_taker/models/restaurant_model.dart';
import 'package:order_taker/services/firestore_paths.dart';

class DatabaseService {
  Stream<List<Restaurant>> fetchRestaurants() {
    final restaurantRef =
        FirebaseFirestore.instance.collection(FirestorePath.restaurants());
    final restaurantSnapshot = restaurantRef.snapshots();
    return restaurantSnapshot.map(
      (QuerySnapshot querySnapshot) => querySnapshot.docs
          .map(
            (restaurant) => Restaurant(
              title: restaurant["title"],
              desc: restaurant["description"],
              openHours: restaurant["openHours"],
            ),
          )
          .toList(),
    );
  }

  Stream<List<Reservation>> fetchReservations(String uid) {
    final reservationsSnapshot = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid))
        .snapshots();

    return reservationsSnapshot
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((order) => Reservation(
                  id: order.id,
                  restaurant: order["title"],
                  date: order["date"],
                  imagepath: order["imagePath"],
                  numberOfPeople: order["numberOfPeople"],
                ))
            .toList());
  }

  void addReservation(
      String uid, String title, String date, int numberOfPeople) {
    final userReservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    final restaurantReservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.restaurantReservations(title));
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
        .set({"title": title, "date": date, "numberOfPeople": numberOfPeople}));
  }

  Future<void> deleteReservation(String uid, String id) async {
    final reservationRef = FirebaseFirestore.instance
        .collection(FirestorePath.userReservations(uid));
    await reservationRef.doc(id).delete();
  }

  Future<String> fetchMobileNumber(String uid) async {
    final userCollection =
        FirebaseFirestore.instance.doc(FirestorePath.user(uid));
    return userCollection.get().then((value) => value["Mobile Number"]);
  }

  Future<String> setMobileNumber(String uid, String mobileNumber) async {
    print(uid);
    print(mobileNumber);
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
}
