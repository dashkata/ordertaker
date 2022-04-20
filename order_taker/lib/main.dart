import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/screens/auth_page/auth_checker_page.dart';
import 'package:order_taker/screens/login_page/login.dart';
import 'package:order_taker/screens/profile_page/profile.dart';
import 'package:order_taker/screens/restaurant_screens/restaurant_orders_page/restaurant_order.dart';
import 'package:order_taker/screens/restaurant_screens/restaurant_register_page/restaurant_register.dart';
import 'package:order_taker/screens/user_screens/bill_page/bill.dart';
import 'package:order_taker/screens/user_screens/confirm_reservation_page/confirm_reservation.dart';
import 'package:order_taker/screens/user_screens/menu_page/menu.dart';
import 'package:order_taker/screens/user_screens/register_page/register.dart';
import 'package:order_taker/screens/user_screens/reservations_page/reservations.dart';
import 'package:order_taker/screens/user_screens/restaurant_info_page/restaurant_info.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurants.dart';

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
      initialRoute: '/auth',
      routes: {
        '/login': (context) => LoginPage(),
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
