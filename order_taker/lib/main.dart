import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/auth_screen/auth_checker_screen.dart';
import 'package:order_taker/views/login_screen/login.dart';
import 'package:order_taker/views/restaurant_screens/restaurant_orders_screen/restaurant_order.dart';
import 'package:order_taker/views/restaurant_screens/restaurant_register_screen/restaurant_register.dart';
import 'package:order_taker/views/user_screens/bill_screen/bill.dart';
import 'package:order_taker/views/user_screens/confirm_reservation_screen/confirm_reservation.dart';
import 'package:order_taker/views/user_screens/menu_screen/menu.dart';
import 'package:order_taker/views/user_screens/profile_screen/profile.dart';
import 'package:order_taker/views/user_screens/register_screen/register.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservations.dart';
import 'package:order_taker/views/user_screens/restaurant_info_screen/restaurant_info.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    builder: (context) => const ProviderScope(child: OrderTaker()),
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
        '/bill': (context) => const BillPage(),
        '/restaurant_order': (context) => const OrdersPage(),
        '/auth': (context) => const AuthChecker(),
      },
    );
  }
}
