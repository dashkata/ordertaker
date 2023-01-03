import 'package:flutter_test/flutter_test.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/domain/repositories/order_repo.dart';

class EmptyOrderRepoMock extends Fake implements OrderRepo {
  @override
  Stream<List<UserOrder>> fetchOrdersUser(
    Reservation reservation,
    String uid,
  ) =>
      const Stream.empty();
}

class OrderRepoMock extends Fake implements OrderRepo {
  @override
  Stream<List<UserOrder>> fetchOrdersUser(
    Reservation reservation,
    String uid,
  ) =>
      Stream.value([UserOrder.empty()]);
}
