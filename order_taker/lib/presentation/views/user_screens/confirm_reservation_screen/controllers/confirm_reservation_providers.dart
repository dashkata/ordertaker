import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'user_confirm_reservation_controller.dart';

final detailsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final auth = ref.watch(authRepositoryProvider);
  final db = ref.watch(firestoreAPIProvider);
  return {
    'name': auth.getCurrentUser()!.displayName,
    'email': auth.getCurrentUser()!.email,
    'phoneNumber': await db.fetchMobileNumber(auth.getCurrentUser()!.uid)
  };
});
final confirmDateProvider = StateProvider.autoDispose<String>((ref) => '');

final confirmTimeProvider = StateProvider.autoDispose<String>((ref) => '');

final userConfirmReservationControllerProvider =
    StateNotifierProvider.autoDispose<UserConfirmReservationController, void>(
  (ref) => UserConfirmReservationController(
    reservationRepo: ref.watch(reservationRepositoryProvider),
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
