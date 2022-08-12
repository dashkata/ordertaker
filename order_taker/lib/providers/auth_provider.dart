import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/repository_providers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChange;
});

final userTypeProvider = FutureProvider((ref) => ref
    .watch(firestoreRepositoryProvider)
    .fetchUserType(ref.read(authRepositoryProvider).getCurrentUser()!.uid));
