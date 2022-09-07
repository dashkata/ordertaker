import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_model.dart';
import '../models/reservation_model.dart';
import 'repository_providers.dart';

final fetchOrdersProvider = FutureProvider.family<List<Order>, Reservation>(
  (ref, reservation) async =>
      ref.watch(firestoreRepositoryProvider).fetchOrdersUser(
            reservation,
            ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
          ),
);
