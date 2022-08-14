import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/screens/login_page/login.dart';
import 'package:order_taker/screens/owner_screens/edit_menu_screen/edit_menu.dart';
import 'package:order_taker/screens/restaurant_screens/restaurant_orders_page/restaurant_order.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    final _authServices = ref.watch(authServicesProvider);
    final db = ref.watch(databaseProvider);
    AsyncValue userType = ref.watch(userTypeProvider);
    return _authState.when(data: ((data) {
      return userType.when(
          data: (value) {
            if (data != null && _authServices.getCurrentUser()!.emailVerified) {
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
