import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/menu_item_model.dart';
import '../../../../models/menu_section_model.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../providers/repository_providers.dart';

final restaurantInformationProvider = FutureProvider<Restaurant>(
  (ref) async =>
      await ref.read(firestoreRepositoryProvider).fetchRestaurantInfo(
            await ref.read(firestoreRepositoryProvider).fetchRestaurantTitle(
                  ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                ),
          ),
);
final menuProvider = StreamProvider.family<List<MenuSection>, String>(
  (ref, title) => ref.watch(firestoreRepositoryProvider).fetchMenu(
        title,
      ),
);
