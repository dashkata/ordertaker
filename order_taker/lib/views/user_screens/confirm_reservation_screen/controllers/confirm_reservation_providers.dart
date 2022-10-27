import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/user_screens/confirm_reservation_screen/controllers/user_confirm_reservation_controller.dart';

import '../../../../providers/repository_providers.dart';

final detailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final auth = ref.watch(authRepositoryProvider);
  final db = ref.watch(firestoreRepositoryProvider);
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
    firestoreRepository: ref.watch(firestoreRepositoryProvider),
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
  ),
);