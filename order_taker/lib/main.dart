import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:order_taker/Screens/ProfilePage/profile.dart';
import 'package:order_taker/Screens/UserScreens/reservationspage/reservations.dart';
import 'package:order_taker/Screens/RegisterPage/register.dart';

import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurants.dart';
import 'package:order_taker/Screens/loginpage/login.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => const OrderTaker(),
    enabled: !kReleaseMode,
  ));
}

class OrderTaker extends StatelessWidget {
  const OrderTaker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      initialRoute: '/restaurants',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/restaurants': (context) => const RestaurantPage(),
        '/reservations': (context) => const ReservationPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
