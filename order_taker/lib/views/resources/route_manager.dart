import 'package:flutter/material.dart';
import '../auth_screen/auth_checker_screen.dart';
import '../login_screen/login.dart';
import '../owner_restaurant_info/owner_restaurant_info.dart';
import '../owner_screens/owner_onboarding/onboarding.dart';
import '../owner_screens/restaurant_register_screen/restaurant_register.dart';
import '../restaurant_screens/restaurant_menu_screen/restaurant_menu.dart';
import '../restaurant_screens/restaurant_orders_screen/restaurant_order.dart';
import '../restaurant_screens/restaurant_request_screen/restaurant_request.dart';
import '../restaurant_screens/restaurant_reservations_screen/restaurant_reservations.dart';
import '../restaurant_screens/restaurant_tables_screen/restaurant_tables.dart';
import '../user_screens/bill_screen/bill.dart';
import '../user_screens/confirm_reservation_screen/confirm_reservation.dart';
import '../user_screens/menu_screen/menu.dart';
import '../user_screens/profile_screen/profile.dart';
import '../user_screens/register_screen/register.dart';
import '../user_screens/reservations_screen/reservations.dart';
import '../user_screens/restaurant_screen/restaurants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String login = 'login';
  static const String register = 'register';
  static const String auth = 'auth';
  static const String profile = 'profile';
  static const String userRestaurants = 'user_restaurants';
  static const String userReservations = 'user_reservations';
  static const String userRestaurantInfo = 'user_restaurant_info';
  static const String userMenu = 'user_menu';
  static const String userConfirmReserveration = 'user_confirm_reservation';
  static const String userBill = 'bill';
  static const String restaurantRegister = 'restaurant_register';
  static const String restaurantOrders = 'restaurant_orders';
  static const String restaurantTables = 'restaurant_tables';
  static const String restaurantReservations = 'restaurant_reservations';
  static const String restaurantRequests = 'restaurant_requests';
  static const String restaurantMenu = 'restaurant_menu';
  static const String ownerOnboarding = 'onboarding';
  static const String ownerRestaurantInfo = 'owner_restaurant_info';
  static const String ownerEditAccounts = 'owner_edit_accounts';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthChecker(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.userRestaurants:
        return MaterialPageRoute(
          builder: (_) => const RestaurantScreen(),
        );
      case Routes.userReservations:
        return MaterialPageRoute(
          builder: (_) => const ReservationScreen(),
        );
      case Routes.userMenu:
        return MaterialPageRoute(
          builder: (_) => const MenuScreen(),
          settings: settings,
        );
      case Routes.userConfirmReserveration:
        return MaterialPageRoute(
          builder: (_) => const ConfirmReservationScreen(),
          settings: settings,
        );
      case Routes.userBill:
        return MaterialPageRoute(
          builder: (_) => const BillScreen(),
          settings: settings,
        );
      case Routes.restaurantRegister:
        return MaterialPageRoute(
          builder: (_) => const RestaurantRegister(),
        );
      case Routes.restaurantOrders:
        return MaterialPageRoute(
          builder: (_) => const RestaurantOrders(),
          settings: settings,
        );
      case Routes.restaurantTables:
        return MaterialPageRoute(
          builder: (_) => const RestaurantTables(),
        );
      case Routes.restaurantReservations:
        return MaterialPageRoute(
          builder: (_) => const RestaurantReservations(),
          settings: settings,
        );
      case Routes.restaurantMenu:
        return MaterialPageRoute(
          builder: (_) => const RestaurantMenu(),
          settings: settings,
        );
      case Routes.restaurantRequests:
        return MaterialPageRoute(
          builder: (_) => const RestaurantRequests(),
          settings: settings,
        );
      case Routes.ownerOnboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.ownerRestaurantInfo:
        return MaterialPageRoute(
          builder: (_) => const OwnerRestaurantInfo(),
          settings: settings,
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
