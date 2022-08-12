import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/repository_providers.dart';

import '../login_screen/login.dart';
import '../owner_screens/edit_menu_screen/edit_menu.dart';
import '../restaurant_screens/restaurant_orders_screen/restaurant_order.dart';
import '../user_screens/restaurant_screen/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    final _authServices = ref.watch(authRepositoryProvider);
    final db = ref.watch(firestoreRepositoryProvider);
    AsyncValue userType = ref.watch(userTypeProvider);
    return _authState.when(data: ((data) {
      if (data != null) {
        return userType.when(
            data: (value) {
              if (data != null &&
                  _authServices.getCurrentUser()!.emailVerified &&
                  value != null) {
                if (value == "Customer") {
                  return const RestaurantPage();
                } else if (value == "Admin") {
                  return const EditMenu();
                } else {
                  return const OrdersPage();
                }
              } else {
                return LoginPage();
              }
            },
            loading: () => const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
            error: (Object error, StackTrace? stackTrace) => Scaffold(
                  body: Center(child: Text(error.toString())),
                ));
      }
      return LoginPage();
    }), error: (e, s) {
      return Scaffold(
        body: Center(child: Text(e.toString())),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }
}
