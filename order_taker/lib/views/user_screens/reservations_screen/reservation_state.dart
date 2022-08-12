import 'package:order_taker/models/reservation_model.dart';

abstract class ReservationState {
  const ReservationState();
}

class ReservationLoading extends ReservationState {
  const ReservationLoading();
}

class ReservationLoaded extends ReservationState {
  final List<Reservation> reservations;

  const ReservationLoaded(this.reservations);
}

class ReservationError extends ReservationState {
  final String message;

  const ReservationError(this.message);
}
