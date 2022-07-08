import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';

final phoneNumberProvider = FutureProvider<String>((ref) async {
  final _db = ref.watch(databaseProvider);
  final _mobileNumber = await _db
      .fetchMobileNumber(ref.watch(authServicesProvider).getCurrentUser()!.uid);
  return _mobileNumber;
});
final passwordChangeProvider = StateProvider((ref) => false);
final nameChangeProvider = StateProvider((ref) => false);

final emailChangeProvider = StateProvider((ref) => false);

final phoneChangeProvider = StateProvider((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final picProvider = FutureProvider.autoDispose<String?>((ref) async {
  final _storage = ref.watch(storageProvider);

  return await _storage.fetchProfilePic(
      email: ref.read(authServicesProvider).getCurrentUser()!.email!);
});
