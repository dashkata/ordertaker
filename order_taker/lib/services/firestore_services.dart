import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurant_widget.dart';

class DatabaseService {
  Future<List<RestaurantCard>> fetchRestaurants() async {
    final restaurantRef = FirebaseFirestore.instance.collection('Restaurants');

    final restaurantSnapshot = await restaurantRef.get();
    return restaurantSnapshot.docs
        .map<RestaurantCard>(
          (restaurant) => RestaurantCard(
            resTitle: restaurant["title"],
            resDesc: restaurant["description"],
            imagePath: restaurant["imagepath"],
          ),
        )
        .toList();
  }
}
