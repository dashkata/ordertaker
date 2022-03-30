import 'package:flutter/material.dart';
import 'package:order_taker/Screens/UserScreens/reservationspage/reservations.dart';
import 'package:order_taker/Screens/registerpage/register.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurants.dart';
import 'Screens/loginpage/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/restaurants',
    routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/restaurants': (context) => const RestaurantPage(),
      'reservations': (context) => const ReservationPage(),
    },
  ));
}
