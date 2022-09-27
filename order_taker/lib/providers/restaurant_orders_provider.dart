import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../views/restaurant_screens/restaurant_orders_screen/restaurant_order_arguments.dart';
import 'repository_providers.dart';

final fetchRestaurantOrdersProvider =
    StreamProvider.family<List<Order>, RestaurantOrderArguments>(
  (ref, args) => ref
      .watch(firestoreRepositoryProvider)
      .fetchOrdersRestaurant(args.id.toString(), args.restaurantTitle),
);
final docChangesProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .listenForOrders('Pizza Don Vito', '2'),
);
