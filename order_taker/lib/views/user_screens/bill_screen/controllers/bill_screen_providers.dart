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

final billScreenControllerProvider =
    StateNotifierProvider<BillScreenController, void>(
  (ref) => BillScreenController(ref: ref),
);

final reviewMessageProvider = StateProvider<String>((ref) => '');
final reviewRatingProvider = StateProvider<double>((ref) => 0);
