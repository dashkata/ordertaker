import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';

class EditAccountsNotifier extends StateNotifier<void> {
  EditAccountsNotifier({required StateNotifierProviderRef ref})
      : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  Future<void> registerAccount(String email, String password) async {
    await _ref
        .read(authRepositoryProvider)
        .adminSignUp(email: email, password: password);
  }
}
