import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/api/firestore_api.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/database_repository.dart';
import 'package:order_taker/data/repositories/storage_repository.dart';
import 'package:order_taker/domain/repositories/menu_repo.dart';
import 'package:order_taker/domain/repositories/order_repo.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/review_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

import 'auth_provider.dart';

final apiProvider = Provider<API>((ref) => API());
final storageRepositoryProvider =
    Provider<StorageRepository>((ref) => StorageRepository());
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
  ),
);

final restaurantRepositoryProvider = Provider<RestaurantRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);
final reservationRepositoryProvider = Provider<ReservationRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);
final userRepositoryProvider = Provider<UserRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);
final menuRepositoryProvider = Provider<MenuRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);

final reviewRepositoryProvider = Provider<ReviewRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);
final orderRepositoryProvider = Provider<OrderRepo>(
  (ref) => DatabaseRepository(
    api: ref.watch(apiProvider),
  ),
);
