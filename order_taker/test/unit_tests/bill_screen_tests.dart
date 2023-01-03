import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';
import 'package:order_taker/presentation/views/user_screens/bill_screen/controllers/bill_screen_providers.dart';

import '../mocks/order_repo_mock.dart';

void main() {
  test('Test fetching user orders with no data.', () {
    final container = ProviderContainer(
      overrides: [
        orderRepositoryProvider.overrideWith((ref) => EmptyOrderRepoMock()),
        fetchOrdersProvider.overrideWith(
          (ref, arg) => ref.watch(orderRepositoryProvider).fetchOrdersUser(
                Reservation.empty(),
                '',
              ),
        )
      ],
    );
    final ordersProvider =
        container.read(fetchOrdersProvider(Reservation.empty()));
    expect(
      ordersProvider,
      const AsyncLoading<List<UserOrder>>(),
    );
    expect(
      ordersProvider.value,
      null,
    );
  });
  test('Test fetching user orders with orders.', () async* {
    final container = ProviderContainer(
      overrides: [
        orderRepositoryProvider.overrideWith((ref) => OrderRepoMock()),
        fetchOrdersProvider.overrideWith(
          (ref, arg) => ref.watch(orderRepositoryProvider).fetchOrdersUser(
                Reservation.empty(),
                '',
              ),
        )
      ],
    );
    final ordersProvider =
        container.read(fetchOrdersProvider(Reservation.empty()).stream);
    expect(
      ordersProvider,
      [Reservation.empty()],
    );
    expect(
      ordersProvider.elementAt(0),
      Reservation.empty(),
    );
  });
}
