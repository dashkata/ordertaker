import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/repository_providers.dart';

import '../models/restaurant_model.dart';

class UserServices {
  UserServices(this.ref);

  final Ref ref;

  Future<List<Restaurant>> fetchRestaurants() {
    return ref.read(firestoreRepositoryProvider).fetchRestaurants();
  }

  Future<List<Reservation>> fetchReservations(String uid) {
    return ref.read(firestoreRepositoryProvider).fetchReservations(uid);
  }
}
