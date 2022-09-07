import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDateProvider = StateProvider.autoDispose<String>((ref) => '');

final peopleProvider = StateProvider<int>((ref) => 0);

// final userRestaurantListProvider = StreamProvider((ref) {
//   return ref.watch(userServicesProvider).fetchRestaurants();
// });
