import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../restaurant_order_arguments.dart';
import 'restaurant_order_viewmodel.dart';

final restaurantOrdersProvider = StreamProvider.family
    .autoDispose<List<UserOrder>, RestaurantOrderArguments>(
  (ref, args) => ref
      .watch(orderRepositoryProvider)
      .fetchOrdersRestaurant(args.id.toString(), args.restaurantTitle),
);

final restaurantOrderViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantOrderViewModel, void>(
  (ref) => RestaurantOrderViewModel(
    orderRepo: ref.read(orderRepositoryProvider),
  ),
);
