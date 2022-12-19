import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository_providers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChange,
);

final userTypeProvider = FutureProvider.autoDispose(
  (ref) async => await ref
      .watch(userRepositoryProvider)
      .fetchUserType(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
final onBoardingProvider = FutureProvider.autoDispose<bool>(
  (ref) async => await ref
      .watch(userRepositoryProvider)
      .fetchOnBoarding(ref.read(authRepositoryProvider).getCurrentUser()!.uid),
);
