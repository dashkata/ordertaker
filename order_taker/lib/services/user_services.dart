import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reservation_model.dart';
import '../providers/repository_providers.dart';

class UserServices {
  UserServices(this.ref);

  final Ref ref;

  void addReservation(String uid, Reservation reservation) {
    ref.read(firestoreRepositoryProvider).addReservation(uid, reservation);
  }

  Future<void> deleteReservation(String uid, Reservation reservation) async {
    await ref
        .read(firestoreRepositoryProvider)
        .deleteReservation(uid, reservation);
  }
}
