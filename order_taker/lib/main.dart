import 'package:flutter/material.dart';
import 'package:order_taker/navigation/registerpage/registerpage.dart';
import 'package:order_taker/navigation/restaurantpage/restaurantpage.dart';
import 'navigation/loginpage/loginpage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/restaurants',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/restaurants': (context) => RestaurantPage()
    },
  ));
}
