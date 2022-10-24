import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';

class EditAccountsNotifier extends StateNotifier<void> {
  EditAccountsNotifier({required StateNotifierProviderRef ref})
      : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  Future<void> registerAccount(String email,
      String password,
      // String restaurantTitle,
      ) async {
    final restaurantTitle = await _ref.watch(firestoreRepositoryProvider)
        .fetchRestaurantTitle(
      _ref.watch(authRepositoryProvider).getCurrentUser()!.uid,);
    await _ref.read(authRepositoryProvider).adminSignUp(
      email: email,
      password: password,
      restaurantTitle: restaurantTitle,
    );
  }
}
