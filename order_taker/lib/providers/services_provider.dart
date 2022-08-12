import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/services/user_services.dart';

final userServicesProvider = Provider<UserServices>((ref) {
  return UserServices(ref);
});
