import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../restaurant_order_arguments.dart';
import 'restaurant_order_controller.dart';

final restaurantOrdersProvider =
    StreamProvider.family<List<UserOrder>, RestaurantOrderArguments>(
  (ref, args) => ref
      .watch(orderRepositoryProvider)
      .fetchOrdersRestaurant(args.id.toString(), args.restaurantTitle),
);

final restaurantOrderControllerProvider =
    StateNotifierProvider<RestaurantOrderController, void>(
  (ref) => RestaurantOrderController(ref: ref),
);
