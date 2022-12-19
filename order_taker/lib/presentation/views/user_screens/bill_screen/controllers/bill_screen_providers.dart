import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'bill_screen_controller.dart';

final fetchOrdersProvider = StreamProvider.family<List<UserOrder>, Reservation>(
  (ref, reservation) => ref.watch(firestoreAPIProvider).fetchOrdersUser(
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
final totalPriceProvider = StateProvider.family<double, List<UserOrder>>(
  (ref, orders) =>
      ref.read(billScreenControllerProvider.notifier).getTotalPrice(orders),
);
