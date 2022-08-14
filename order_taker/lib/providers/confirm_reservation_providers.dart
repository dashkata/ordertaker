import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';

final detailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final _auth = ref.watch(authServicesProvider);
  final _db = ref.watch(databaseProvider);
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
