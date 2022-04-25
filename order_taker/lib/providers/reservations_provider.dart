import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';

final reservations_provider = StreamProvider((ref) {
  final currentUser = ref.watch(authServicesProvider).getCurrentUser();
  return ref.read(databaseProvider).fetchReservations(currentUser!.uid);
});
