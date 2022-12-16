import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../restaurant_order_arguments.dart';
import 'restaurant_order_controller.dart';

final restaurantOrdersProvider =
    StreamProvider.family<List<UserOrder>, RestaurantOrderArguments>(
  (ref, args) => ref
      .watch(firestoreRepositoryProvider)
      .fetchOrdersRestaurant(args.id.toString(), args.restaurantTitle),
);
final docChangesProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .listenForOrders('Pizza Don Vito', '2'),
);

final restaurantOrderControllerProvider =
    StateNotifierProvider<RestaurantOrderController, void>(
  (ref) => RestaurantOrderController(ref: ref),
);
