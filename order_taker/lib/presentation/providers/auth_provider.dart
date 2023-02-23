import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository_providers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateProvider = StreamProvider.autoDispose<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChange,
);

final futureUserTypeProvider = FutureProvider.autoDispose(
  (ref) async => await ref
      .watch(userRepositoryProvider)
      .fetchUserType(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
final futureOnBoardingProvider = FutureProvider.autoDispose(
  (ref) async => await ref
      .watch(userRepositoryProvider)
      .fetchOnBoarding(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
