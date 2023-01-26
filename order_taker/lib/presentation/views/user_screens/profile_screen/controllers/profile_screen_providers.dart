import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import 'user_profile_viewmodel.dart';

final phoneNumberProvider = FutureProvider.autoDispose<String>((ref) async {
  final db = ref.watch(apiProvider);
  final mobileNumber = await db.fetchMobileNumber(
    ref.watch(authRepositoryProvider).getCurrentUser()!.uid,
  );
  return mobileNumber;
});
final passwordChangeProvider = StateProvider.autoDispose((ref) => false);
final nameChangeProvider = StateProvider.autoDispose((ref) => false);

final emailChangeProvider = StateProvider.autoDispose((ref) => false);

final phoneChangeProvider = StateProvider.autoDispose((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final picProvider = FutureProvider.autoDispose<String?>((ref) async {
  final storage = ref.watch(storageRepositoryProvider);
  return await storage.fetchProfilePic(
    email: ref.read(authRepositoryProvider).getCurrentUser()!.email!,
  );
});
final userProfileViewModelProvider =
    StateNotifierProvider.autoDispose<UserProfileViewModel, void>(
  (ref) => UserProfileViewModel(
    authRepository: ref.watch(authRepositoryProvider),
    userRepo: ref.watch(
      userRepositoryProvider,
    ),
    restaurantRepo: ref.watch(restaurantRepositoryProvider),
    storageRepository: ref.watch(
      storageRepositoryProvider,
    ),
  ),
);
final restaurantEmailProvider = FutureProvider.autoDispose<String?>(
  (ref) => ref.read(restaurantRepositoryProvider).getRestauarntEmail(
        ref.read(authRepositoryProvider).getCurrentUser()!.uid,
      ),
);
final restaurantEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
