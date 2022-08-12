import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/repository_providers.dart';

final detailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final _auth = ref.watch(authRepositoryProvider);
  final _db = ref.watch(firestoreRepositoryProvider);
  return {
    "name": _auth.getCurrentUser()!.displayName,
    "email": _auth.getCurrentUser()!.email,
    "phoneNumber": await _db.fetchMobileNumber(_auth.getCurrentUser()!.uid)
  };
});
final confirmDateProvider = StateProvider<String>((ref) {
  return "";
});

final confirmTimeProvider = StateProvider<String>((ref) {
  return "";
});
