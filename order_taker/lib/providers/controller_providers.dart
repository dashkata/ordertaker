import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/storage_state_notifier.dart';
import '../models/menu_item_model.dart';
import '../views/login_screen/controllers/login_state_controller.dart';
import '../views/owner_screens/restaurant_register_screen/controllers/restaurant_register_controller.dart';
import '../views/restaurant_screens/restaurant_orders_screen/controllers/restaurant_order_controller.dart';
import '../views/restaurant_screens/restaurant_tables_screen/controllers/restaurant_tables_controller.dart';
import '../views/user_screens/confirm_reservation_screen/controllers/user_confirm_reservation_controller.dart';
import '../views/user_screens/menu_screen/controllers/menu_function_notifier.dart';
import '../views/user_screens/menu_screen/controllers/menu_screen_notifier.dart';
import '../views/user_screens/profile_screen/controllers/user_profile_controller.dart';
import '../views/user_screens/register_screen/controllers/user_register_controller.dart';
import '../views/user_screens/reservations_screen/controllers/user_reservation_state.dart';
import '../views/user_screens/restaurant_screen/controllers/restaurant_state_controller.dart';
import 'repository_providers.dart';
import 'services_provider.dart';


final storageStateNotifierProvider =
StateNotifierProvider.autoDispose<StorageStateNotifier, AsyncValue<String>>(
        (ref) => StorageStateNotifier(ref.watch(storageServicesProvider)),
);









