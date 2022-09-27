import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository_providers.dart';

final detailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final auth = ref.watch(authRepositoryProvider);
  final db = ref.watch(firestoreRepositoryProvider);
  return {
    'name': auth.getCurrentUser()!.displayName,
    'email': auth.getCurrentUser()!.email,
    'phoneNumber': await db.fetchMobileNumber(auth.getCurrentUser()!.uid)
  };
});
final confirmDateProvider = StateProvider<String>((ref) => '');

final confirmTimeProvider = StateProvider<String>((ref) => '');
