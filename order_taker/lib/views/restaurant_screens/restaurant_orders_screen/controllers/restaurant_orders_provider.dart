import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/restaurant_screens/restaurant_orders_screen/controllers/restaurant_order_controller.dart';
import '../../../../models/order_model.dart';
import '../../restaurant_tables_screen/controllers/restaurant_tables_controller.dart';
import '../restaurant_order_arguments.dart';
import '../../../../providers/repository_providers.dart';

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

final restaurantOrderNotifierProvider =
StateNotifierProvider<RestaurantOrderNotifier, void>(
        (ref) => RestaurantOrderNotifier(ref: ref),
);

