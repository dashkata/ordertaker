import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repository_providers.dart';

import '../custom_widgets/custom_progress_indicator.dart';
import '../login_screen/login.dart';
import '../owner_screens/owner_onboarding/onboarding.dart';
import '../restaurant_info_screen/restaurant_info.dart';
import '../restaurant_screens/restaurant_tables_screen/restaurant_tables.dart';
import '../user_screens/restaurant_screen/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authServices = ref.watch(authRepositoryProvider);

    return authState.when(
      data: (data) {
        if (data != null) {
          final AsyncValue userType = ref.watch(userTypeProvider);
          return userType.when(
            data: (value) {
              if (authServices.getCurrentUser()!.emailVerified &&
                  value != 'Restaurant') {
                if (value == 'Customer') {
                  return const RestaurantScreen();
                } else if (value == 'Admin') {
                  return ref.watch(onBoardingProvider).when(
                        data: (onBoarding) => onBoarding
                            ? const RestaurantInfo()
                            : const OnboardingScreen(),
                        error: (e, s) => Text(e.toString()),
                        loading: () => const CustomProgressIndicator(),
                      );
                } else {
                  return const LoginScreen();
                }
              } else {
                return const RestaurantTables();
              }
            },
            loading: () => const Scaffold(
              body: Center(child: CustomProgressIndicator()),
            ),
            error: (Object error, StackTrace? stackTrace) =>
                const LoginScreen(),
          );
        } else {
          return const LoginScreen();
        }
      },
      error: (e, s) => const LoginScreen(),
      loading: () => const Scaffold(
        body: Center(
          child: CustomProgressIndicator(),
        ),
      ),
    );
  }
}
