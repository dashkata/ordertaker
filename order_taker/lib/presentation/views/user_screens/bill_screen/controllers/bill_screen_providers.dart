import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'bill_screen_controller.dart';

final fetchOrdersProvider =
    StreamProvider.family.autoDispose<List<UserOrder>, Reservation>(
  (ref, reservation) => ref.watch(orderRepositoryProvider).fetchOrdersUser(
        reservation,
        ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);

final billScreenControllerProvider =
    StateNotifierProvider.autoDispose<BillScreenController, void>(
  (ref) => BillScreenController(
    reviewRepo: ref.read(reviewRepositoryProvider),
    authRepository: ref.read(authRepositoryProvider),
    reservationRepo: ref.read(reservationRepositoryProvider),
  ),
);

final reviewMessageProvider = StateProvider.autoDispose<String>((ref) => '');
final reviewRatingProvider = StateProvider.autoDispose<double>((ref) => 0);
final totalPriceProvider =
    StateProvider.family.autoDispose<double, List<UserOrder>>(
  (ref, orders) =>
      ref.read(billScreenControllerProvider.notifier).getTotalPrice(orders),
);
