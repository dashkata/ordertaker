import 'package:flutter/material.dart';
import 'package:order_taker/Screens/registerpage/registerpage.dart';
import 'package:order_taker/Screens/restaurantpage/restaurantpage.dart';
import 'Screens/loginpage/loginpage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
      '/restaurants': (context) => RestaurantPage()
    },
  ));
}
