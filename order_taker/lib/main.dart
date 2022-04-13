import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:order_taker/Screens/ProfilePage/profile.dart';
import 'package:order_taker/Screens/RestaurantScreens/RestaurantRegisterPage/restaurant_register.dart';
import 'package:order_taker/Screens/UserScreens/confirmreservationpage/confirm_reservation.dart';
import 'package:order_taker/Screens/UserScreens/reservationspage/reservations.dart';
import 'package:order_taker/Screens/UserScreens/RegisterPage/register.dart';
import 'package:order_taker/Screens/UserScreens/restaurantinfopage/restaurant_info.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurants.dart';
import 'package:order_taker/Screens/loginpage/login.dart';
import 'Screens/UserScreens/menupage/menu.dart';

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
      initialRoute: '/menu',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/restaurants': (context) => const RestaurantPage(),
        '/reservations': (context) => const ReservationPage(),
        '/profile': (context) => const ProfilePage(),
        '/restaurant_info': (context) => const RestaurantInfo(),
        '/confirm_reservation': (context) => const ConfirmReservation(),
        '/restaurant_register': (context) => const RestaurantRegister(),
        '/menu': (context) => const Menu(),
      },
    );
  }
}
