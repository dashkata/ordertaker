import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/repository_providers.dart';
import '../../../resources/route_manager.dart';

class RestaurantRegisterNotifier extends StateNotifier<void> {
  RestaurantRegisterNotifier({required Ref ref})
      : _ref = ref,
        super(null);
  final Ref _ref;

  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
    String phoneNumber,
    String restaurantName,
  ) async {
    final auth = _ref.watch(authRepositoryProvider);
    final firestore = _ref.watch(firestoreRepositoryProvider);
    await auth
        .signUp(email: email, password: password)
        .then(
          (value) => auth.getCurrentUser()!.sendEmailVerification(),
        )
        .then(
          (value) => firestore.setRestaurantTitle(
            restaurantName,
            auth.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => firestore.setMobileNumber(
            auth.getCurrentUser()!.uid,
            phoneNumber,
          ),
        )
        .then(
          (value) => firestore.setUserType(
            'Admin',
            auth.getCurrentUser()!.uid,
          ),
        )
        .then(
          (value) => auth.updateUserName(
            name: '$firstName $lastName',
          ),
        )
        .then(
          (value) => firestore.setOnBoarding(
            auth.getCurrentUser()!.uid,
            onBoarding: false,
          ),
        );
  }

  void navigateToLogin() {
    navigatorKey.currentState!.popAndPushNamed(Routes.login);
  }

  void navigateToRegister() {
    navigatorKey.currentState!.popAndPushNamed(Routes.register);
  }
}