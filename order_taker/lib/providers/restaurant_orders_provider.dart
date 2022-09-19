import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import 'repository_providers.dart';

final fetchRestaurantOrdersProvider = StreamProvider<List<Order>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .fetchOrdersRestaurant('2', 'Pizza Don Vito'),
);
final docChangesProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>(
  (ref) => ref
      .watch(firestoreRepositoryProvider)
      .listenForOrders('Pizza Don Vito', '2'),
);
