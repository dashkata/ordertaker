import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/api/firestore_api.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/firestore_repository.dart';
import 'package:order_taker/data/repositories/storage_repository.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';

import 'auth_provider.dart';

final firestoreAPIProvider = Provider<API>((ref) => API());
final storageRepositoryProvider =
    Provider<StorageRepository>((ref) => StorageRepository());
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
  ),
);

final restaurantRepositoryProvider = Provider<RestaurantRepo>(
  (ref) => FirestoreRepository(
    api: ref.watch(firestoreAPIProvider),
  ),
);
final reservationRepositoryProvider = Provider<ReservationRepo>(
  (ref) => FirestoreRepository(
    api: ref.watch(firestoreAPIProvider),
  ),
);
final userRepositoryProvider = Provider<UserRepo>(
  (ref) => FirestoreRepository(
    api: ref.watch(firestoreAPIProvider),
  ),
);
