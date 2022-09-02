import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

import '../models/order_model.dart';

final fetchOrdersProvider = FutureProvider.family<List<Order>, Reservation>(
    (ref, reservation) async => ref
        .watch(firestoreRepositoryProvider)
        .fetchOrders(reservation,
            ref.watch(authRepositoryProvider).getCurrentUser()!.uid));
