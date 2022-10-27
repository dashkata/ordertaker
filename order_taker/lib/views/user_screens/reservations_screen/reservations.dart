import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/common_providers.dart';
import '../../../providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/route_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/reservation_screen_providers.dart';

part 'widget/reservation_card.dart';

part 'widget/title_column.dart';

part 'widget/cancel_reservation_dialog.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.reservations,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<List<Reservation>> reservations =
                ref.watch(reservationListProvider);
            return reservations.when(
              data: (data) => data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _ReservationCard(reservation: data[index]),
                    )
                  : const Center(
                      child: Text('No reservations at the moment'),
                    ),
              error: (e, s) => ErrorAlertDialog(
                errorMessage: e.toString(),
              ),
              loading: () => const CustomProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
