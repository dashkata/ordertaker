import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../../models/reservation_model.dart';
import '../../../providers/common_providers.dart';
import '../../../providers/confirm_reservation_providers.dart';
import '../../../providers/controller_providers.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../user_screens/restaurant_info_screen/restaurant_info_widget.dart';
import 'widgets/detail_row.dart';
import 'widgets/user_detail.dart';

/*
  We need the user details and we need the user picked date and number of people


*/
class ConfirmReservationScreen extends ConsumerWidget {
  const ConfirmReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final AsyncValue userDetails = ref.watch(detailsProvider);
    final reservationInfo = ModalRoute.of(context)!.settings.arguments as Map;
    final AsyncValue restaurantPic = ref
        .watch(restaurantPictureProvider(reservationInfo['restaurantTitle']));
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: PaddingManager.p7,
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: contentContainerDecoration,
                  child: userDetails.when(
                    data: (data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: PaddingManager.p9,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  restaurantPic.value,
                                ),
                                radius: 45,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reservationInfo['restaurantTitle'],
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: DetailRow(
                                      reservationInfo: reservationInfo,
                                      text: text,
                                    ),
                                  ),
                                  Text(
                                    'Selected table: ${reservationInfo['tableId']}',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const InfoDivider(),
                        UserDetail(
                          detailType: text.name,
                          userDetail: data['name'],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: UserDetail(
                            detailType: text.email_address,
                            userDetail: data['email'],
                          ),
                        ),
                        UserDetail(
                          detailType: text.mobile_number,
                          userDetail: data['phoneNumber'],
                        ),
                        Center(
                          child: NormalButtons(
                            buttonText: text.confirm_reservation,
                            buttonFunc: () => ref
                                .read(userConfirmReservationProvider.notifier)
                                .addReservation(
                                  Reservation(
                                    name: data['name'],
                                    restaurant:
                                        reservationInfo['restaurantTitle'],
                                    date: '${ref.read(confirmDateProvider)} '
                                        '- ${ref.read(confirmTimeProvider)}',
                                    numberOfPeople:
                                        reservationInfo['numberOfPeople'],
                                    selectedTable: reservationInfo['tableId'],
                                    currentReservation: false,
                                  ),
                                ),
                          ),
                        ),
                        Padding(
                          padding: PaddingManager.p2,
                          child: Center(
                            child: NormalButtons(
                              buttonText: text.change_details,
                              buttonFunc: () {
                                //TODO change details
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    error: (e, s) => Text(e.toString()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
