import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'user_confirm_reservation_controller.dart';

final detailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final auth = ref.watch(authRepositoryProvider);
  final db = ref.watch(firestoreAPIProvider);
  return {
    'name': auth.getCurrentUser()!.displayName,
    'email': auth.getCurrentUser()!.email,
    'phoneNumber': await db.fetchMobileNumber(auth.getCurrentUser()!.uid)
  };
});
final confirmDateProvider = StateProvider<String>((ref) => '');

final confirmTimeProvider = StateProvider<String>((ref) => '');

final userConfirmReservationControllerProvider =
    StateNotifierProvider<UserConfirmReservationController, void>(
  (ref) => UserConfirmReservationController(
    reservationRepo: ref.watch(reservationRepositoryProvider),
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);
