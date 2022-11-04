import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/repository_providers.dart';
import 'user_profile_controller.dart';

final phoneNumberProvider = FutureProvider<String>((ref) async {
  final db = ref.watch(firestoreRepositoryProvider);
  final mobileNumber = await db.fetchMobileNumber(
    ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
  );
  return mobileNumber;
});
final passwordChangeProvider = StateProvider((ref) => false);
final nameChangeProvider = StateProvider((ref) => false);

final emailChangeProvider = StateProvider((ref) => false);

final phoneChangeProvider = StateProvider((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final picProvider = FutureProvider.autoDispose<String?>((ref) async {
  final storage = ref.watch(storageRepositoryProvider);
  return await storage.fetchProfilePic(
    email: ref.read(authRepositoryProvider).getCurrentUser()!.email!,
  );
});
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, void>(
  (ref) => UserProfileNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    firestoreRepository: ref.watch(
      firestoreRepositoryProvider,
    ),
    storageRepository: ref.watch(
      storageRepositoryProvider,
    ),
  ),
);
final restaurantEmailProvider = FutureProvider<String?>(
  (ref) => ref.read(firestoreRepositoryProvider).getRestauarntEmail(
        ref.read(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
final restaurantEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
