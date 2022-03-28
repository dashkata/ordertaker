import 'package:flutter/material.dart';
import 'package:order_taker/Screens/registerpage/chooseregister.dart';
import 'package:order_taker/Screens/registerpage/registerpage.dart';
import 'package:order_taker/Screens/restaurantpage/restaurantpage.dart';
import 'Screens/loginpage/loginpage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/restaurants': (context) => const RestaurantPage(),
      '/chooseregister': (context) => const ChooseRegister()
    },
  ));
}
