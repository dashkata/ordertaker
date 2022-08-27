import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/confirm_reservation_providers.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import '../../project_widgets.dart';
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
    AsyncValue userDetails = ref.watch(detailsProvider);
    final reservationInfo = ModalRoute.of(context)!.settings.arguments as Map;
    AsyncValue restaurantPic = ref
        .watch(restaurantPictureProvider(reservationInfo["restaurantTitle"]));
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
                              GFListTile(
                                margin: EdgeInsets.zero,
                                padding: PaddingManager.p19,
                                avatar: GFAvatar(
                                  backgroundImage:
                                      NetworkImage(restaurantPic.value),
                                  shape: GFAvatarShape.square,
                                  borderRadius: BorderRadius.circular(10),
                                  radius: 30,
                                ),
                                title: Text(
                                  reservationInfo["restaurantTitle"],
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                subTitle: DetailRow(
                                  reservationInfo: reservationInfo,
                                  text: text,
                                ),
                              ),
                              const InfoDivider(),
                              UserDetail(
                                detailType: text.name,
                                userDetail: data["name"],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: UserDetail(
                                  detailType: text.email_address,
                                  userDetail: data["email"],
                                ),
                              ),
                              UserDetail(
                                detailType: text.mobile_number,
                                userDetail: data["phoneNumber"],
                              ),
                              Center(
                                child: NormalButtons(
                                  buttonText: text.confirm_reservation,
                                  buttonFunc: () => ref
                                      .read(userConfirmReservationProvider
                                          .notifier)
                                      .addReservation(
                                        Reservation(
                                          name: data["name"],
                                          restaurant: reservationInfo[
                                              "restaurantTitle"],
                                          date:
                                              '${ref.read(confirmDateProvider)} - ${ref.read(confirmTimeProvider)}',
                                          numberOfPeople:
                                              reservationInfo["numberOfPeople"],
                                          selectedTable: 2,
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
                                      }),
                                ),
                              ),
                            ],
                          ),
                      error: (e, s) => Text(e.toString()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator())),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
