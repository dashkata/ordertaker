import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/screens/login_page/login.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurants.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(data: ((data) {
      if (data != null) {
        return const RestaurantPage();
      }
      return LoginPage();
    }), error: (e, s) {
      return const Scaffold(
        body: Center(child: Text("ff")),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }
}