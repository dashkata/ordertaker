import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/auth_provider.dart';
import 'package:order_taker/presentation/providers/common_providers.dart';
import 'package:order_taker/presentation/views/owner_screens/owner_onboarding/onboarding.dart';

import '../custom_widgets/custom_progress_indicator.dart';
import '../login_screen/login.dart';
import '../restaurant_info_screen/restaurant_info.dart';
import '../restaurant_screens/restaurant_tables_screen/restaurant_tables.dart';
import '../user_screens/restaurant_screen/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) {
          final asyncType = ref.watch(futureUserTypeProvider);
          return asyncType.when(
            data: (type) {
              switch (type) {
                case 'Restaurant':
                  return const RestaurantTables();
                case 'Admin':
                  if (data.emailVerified) {
                    return ref.watch(onBoardingProvider)
                        ? const RestaurantInfo()
                        : const OnboardingScreen();
                  }
                  return const LoginScreen();
                case 'Customer':
                  if (data.emailVerified) {
                    return const RestaurantScreen();
                  }
                  return const LoginScreen();
                default:
                  return const LoginScreen();
              }
            },
            error: (e, s) => const LoginScreen(),
            loading: CustomProgressIndicator.new,
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
