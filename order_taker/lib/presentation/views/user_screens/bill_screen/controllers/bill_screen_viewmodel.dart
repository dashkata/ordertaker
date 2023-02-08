import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/domain/repositories/reservation_repo.dart';
import 'package:order_taker/domain/repositories/review_repo.dart';

import '../../../resources/route_manager.dart';

class BillScreenViewModel extends StateNotifier<void> {
  BillScreenViewModel({
    required ReviewRepo reviewRepo,
    required AuthRepository authRepository,
    required ReservationRepo reservationRepo,
  })  : _reviewRepo = reviewRepo,
        _authRepository = authRepository,
        _reservationRepo = reservationRepo,
        super(null);
  final ReviewRepo _reviewRepo;
  final AuthRepository _authRepository;
  final ReservationRepo _reservationRepo;

  void navigateToMenu(Reservation reservation) {
    navigatorKey.currentState!.pushReplacementNamed(
      Routes.userMenu,
      arguments: reservation,
    );
  }

  double getTotalPrice(List<UserOrder> orders) {
    double totalPrice = 0.0;
    for (final order in orders) {
      for (final item in order.menuItems.keys) {
        if (order.menuItems[item] != null) {
          totalPrice += double.parse(
                item.itemPrice.replaceAll('lv.', '').replaceAll(',', '.'),
              ) *
              order.menuItems[item]!;
        }
      }
    }
    return totalPrice;
  }

  Future<void> pay(
    Reservation reservation,
    String reviewMessage,
    double reviewRating,
  ) async {
    if (reviewMessage.isNotEmpty && reviewRating != 0) {
      await _reviewRepo.addRestaurantReview(
        reservation.restaurant,
        Review(
          name: reservation.name,
          email: _authRepository.getCurrentUser()!.email!,
          review: reviewMessage,
          rating: reviewRating,
        ),
      );
    }
    await _reservationRepo.deleteReservation(
      _authRepository.getCurrentUser()!.uid,
      reservation,
    );
    await navigatorKey.currentState!.popAndPushNamed(Routes.userRestaurants);
  }
}
