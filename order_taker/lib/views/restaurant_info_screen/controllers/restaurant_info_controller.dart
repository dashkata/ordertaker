import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/restaurant_details.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../providers/repository_providers.dart';
import 'owner_restaurant_info_providers.dart';

class RestaurantInfoController extends StateNotifier<void> {
  RestaurantInfoController() : super(null);

  void submitRestaurantDetails(
    WidgetRef ref,
    RestaurantDetailsType restaurantDetailsType,
    String updateInfo,
    String restaurantTitle,
  ) {
    ref.read(firestoreRepositoryProvider).updateRestaurantInformation(
          updateInfo,
          restaurantTitle,
          restaurantDetailsType.name,
        );
  }
}
