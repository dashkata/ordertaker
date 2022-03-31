import 'package:flutter/material.dart';
import 'package:order_taker/Screens/ProfilePage/profile.dart';
import 'package:order_taker/Screens/UserScreens/reservationspage/current_reservation.dart';
import 'package:order_taker/Screens/UserScreens/reservationspage/reservations.dart';
import 'package:order_taker/Screens/RegisterPage/register.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/chosen_restaurant.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurants.dart';
import 'package:order_taker/Screens/loginpage/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/currentreservation',
    routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/restaurants': (context) => const RestaurantPage(),
      '/reservations': (context) => const ReservationPage(),
      '/profile': (context) => const ProfilePage(),
      '/chosenrestaurant': (context) => const ChosenRestaurant(),
      '/currentreservation': (context) => const CurrentReservation(),
    },
  ));
}
