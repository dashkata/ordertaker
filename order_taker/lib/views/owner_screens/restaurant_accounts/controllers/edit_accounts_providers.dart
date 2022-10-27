import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'edit_accounts_controller.dart';

final restaurantEmailControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final restaurantPasswordControllerProvider =
    StateProvider.autoDispose<String>((ref) => '');
final editAccountsControllerProvider =
    StateNotifierProvider<EditAccountsController, void>(
  (ref) => EditAccountsController(
    ref: ref,
  ),
);
