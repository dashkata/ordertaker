import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/storage_state_notifier.dart';
import 'services_provider.dart';

final storageStateNotifierProvider =
    StateNotifierProvider.autoDispose<StorageStateNotifier, AsyncValue<String>>(
  (ref) => StorageStateNotifier(ref.watch(storageServicesProvider)),
);
