import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repository_providers.dart';

import '../login_screen/login.dart';
import '../owner_screens/edit_menu_screen/edit_menu.dart';
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
      data: (data) {
        if (data != null) {
          return userType.when(
            data: (value) {
              print(value);
              if (authServices.getCurrentUser()!.emailVerified &&
                  value != null) {
                if (value == 'Customer') {
                  return const RestaurantScreen();
                } else if (value == 'Admin') {
                  return const EditMenu();
                } else {
                  return const RestaurantOrders();
                }
              } else {
                return const LoginScreen();
              }
            },
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (Object error, StackTrace? stackTrace) => Scaffold(
              body: Center(child: Text(error.toString())),
            ),
          );
        }
        return const LoginScreen();
      },
      error: (e, s) => Scaffold(
        body: Center(child: Text(e.toString())),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
