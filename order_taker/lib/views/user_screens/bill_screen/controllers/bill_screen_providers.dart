import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/order_model.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/repository_providers.dart';
import 'bill_screen_controller.dart';

final fetchOrdersProvider = StreamProvider.family<List<Order>, Reservation>(
  (ref, reservation) => ref.watch(firestoreRepositoryProvider).fetchOrdersUser(
        reservation,
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);

final billScreenProvider = StateNotifierProvider<BillScreenNotifier, void>(
  (ref) => BillScreenNotifier(ref: ref),
);
