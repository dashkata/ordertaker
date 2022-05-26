import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';

final phoneNumberProvider = StateProvider((ref) {
  return ref.watch(databaseProvider).fetchMobileNumber(
        uid: ref.read(authServicesProvider).getCurrentUser()!.uid,
      );
});

final passwordChangeProvider = StateProvider((ref) => false);

final nameChangeProvider = StateProvider((ref) => false);

final emailChangeProvider = StateProvider((ref) => false);

final phoneChangeProvider = StateProvider((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final profilePicProvider = StateProvider<XFile?>((ref) => null);
