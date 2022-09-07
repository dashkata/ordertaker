import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import 'repository_providers.dart';

final fetchRestaurantOrdersProvider = StreamProvider<List<Order>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .fetchOrdersRestaurant('2', 'Pizza Don Vito'),
);
