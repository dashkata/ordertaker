import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_accounts_notifier.dart';

final restaurantEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final editAccountsControllerProvider =
    StateNotifierProvider<EditAccountsNotifier, void>(
  (ref) => EditAccountsNotifier(
    ref: ref,
  ),
);
