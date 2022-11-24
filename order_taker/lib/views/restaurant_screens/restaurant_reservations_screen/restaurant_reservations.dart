import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../resources/padding_manager.dart';
import '../../resources/route_manager.dart';
import '../restaurant_orders_screen/restaurant_order_arguments.dart';
import 'controllers/restaurant_reservation_provider.dart';

part 'widgets/restaurant_reservation_card.dart';
part 'widgets/restaurant_reservation_card_alert_dialog.dart';

class RestaurantReservations extends ConsumerWidget {
  const RestaurantReservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final restaurantOrderArguments =
        ModalRoute.of(context)!.settings.arguments as RestaurantOrderArguments;
    return Scaffold(
      // drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(
          '${text.tables} ${restaurantOrderArguments.id} ${text.reservations}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final AsyncValue<List<Reservation>> asyncReservations =
                    ref.watch(
                  restaurantReservationsProvider(
                    restaurantOrderArguments,
                  ),
                );
                return asyncReservations.when(
                  data: (reservations) => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _RestaurantReservationCard(
                      reservation: reservations[index],
                      args: restaurantOrderArguments,
                    ),
                    itemCount: reservations.length,
                  ),
                  error: (e, s) => ErrorAlertDialog(
                    errorMessage: e.toString(),
                  ),
                  loading: () => const CustomProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
