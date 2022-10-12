import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repository_providers.dart';

import '../login_screen/login.dart';
import '../owner_screens/edit_menu_screen/edit_menu.dart';
import '../owner_screens/owner_onboarding/onboarding.dart';
import '../project_widgets.dart';
import '../restaurant_screens/restaurant_orders_screen/restaurant_order.dart';
import '../user_screens/restaurant_screen/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authServices = ref.watch(authRepositoryProvider);
    final AsyncValue userType = ref.watch(userTypeProvider);
    return authState.when(
      data: (data) => userType.when(
        data: (value) {
          if (authServices.getCurrentUser()!.emailVerified && value != null) {
            if (value == 'Customer') {
              return const RestaurantScreen();
            } else if (value == 'Admin') {
              return ref.watch(onBoardingProvider).when(
                    data: (onBoarding) => onBoarding
                        ? const EditMenu()
                        : const OnboardingScreen(),
                    error: (e, s) => Text(e.toString()),
                    loading: () => const LoadingIndicator(),
                  );
            } else {
              return const RestaurantOrders();
            }
          } else {
            return const LoginScreen();
          }
        },
        loading: () => const Scaffold(
          body: Center(child: LoadingIndicator()),
        ),
        error: (Object error, StackTrace? stackTrace) => const LoginScreen(),
      ),
      error: (e, s) => const LoginScreen(),
      loading: () => const Scaffold(
        body: Center(child: LoadingIndicator()),
      ),
    );
  }
}
