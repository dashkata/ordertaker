import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/firestore_repository.dart';
import 'package:order_taker/data/repositories/storage_repository.dart';

import 'auth_provider.dart';

final firestoreRepositoryProvider =
    Provider<FirestoreRepository>((ref) => FirestoreRepository());
final storageRepositoryProvider =
    Provider<StorageRepository>((ref) => StorageRepository());
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.read(firebaseAuthProvider),
  ),
);
