import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/repository_providers.dart';

final phoneNumberProvider = FutureProvider<String>((ref) async {
  final _db = ref.watch(firestoreRepositoryProvider);
  final _mobileNumber = await _db.fetchMobileNumber(
      ref.watch(authRepositoryProvider).getCurrentUser()!.uid);
  return _mobileNumber;
});
final passwordChangeProvider = StateProvider((ref) => false);
final nameChangeProvider = StateProvider((ref) => false);

final emailChangeProvider = StateProvider((ref) => false);

final phoneChangeProvider = StateProvider((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final picProvider = FutureProvider.autoDispose<String?>((ref) async {
  final _storage = ref.watch(storageRepositoryProvider);

  return await _storage.fetchProfilePic(
      email: ref.read(authRepositoryProvider).getCurrentUser()!.email!);
});
