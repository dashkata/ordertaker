import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository_providers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChange,
);

final userTypeProvider = FutureProvider(
  (ref) async => await ref
      .watch(firestoreRepositoryProvider)
      .fetchUserType(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
final onBoardingProvider = FutureProvider<bool>(
  (ref) async => await ref
      .watch(firestoreRepositoryProvider)
      .fetchOnBoarding(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
