import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth_repository.dart';
import '../repositories/firestore_repository.dart';
import '../repositories/storage_repository.dart';
import 'auth_provider.dart';

final firestoreRepositoryProvider =
    Provider<FirestoreRepository>((ref) => FirestoreRepository());
final storageRepositoryProvider =
    Provider<StorageRepository>((ref) => StorageRepository());
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    return AuthRepository(ref.read(firebaseAuthProvider));
  },
);
