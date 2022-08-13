import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/confirm_reservation_providers.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';

import '../../project_widgets.dart';
import '../../user_screens/restaurant_info_screen/restaurant_info_widget.dart';
import 'confirm_reservation_widget.dart';

/*
  We need the user details and we need the user picked date and number of people


*/
class ConfirmReservation extends ConsumerWidget {
  const ConfirmReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
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
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                avatar: GFAvatar(
                                  backgroundImage:
                                      NetworkImage(restaurantPic.value),
                                  shape: GFAvatarShape.square,
                                  borderRadius: BorderRadius.circular(10),
                                  radius: 30,
                                ),
                                title: Text(
                                  reservationInfo["restaurantTitle"],
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: accentColor,
                                  ),
                                ),
                                subTitle: Consumer(
                                  builder: (context, ref, child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 15,
                                          color: accentColor,
                                        ),
                                        Text(
                                          ref.watch(confirmDateProvider),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: accentColor,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.watch_later_outlined,
                                          size: 15,
                                          color: accentColor,
                                        ),
                                        Text(
                                          ref.watch(confirmTimeProvider),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: accentColor,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.person,
                                          size: 15,
                                          color: accentColor,
                                        ),
                                        Text(
                                          "${reservationInfo["numberOfPeople"]} people",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            color: accentColor,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const InfoDivider(),
                              UserDetail(
                                detailType: "Name",
                                userDetail: data["name"],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: UserDetail(
                                  detailType: "Email Address",
                                  userDetail: data["email"],
                                ),
                              ),
                              UserDetail(
                                detailType: "Mobile Number",
                                userDetail: data["phoneNumber"],
                              ),
                              Center(
                                child: NormalButtons(
                                    buttonText: "Confirm Reservation",
                                    buttonFunc: () {
                                      ref.read(userServicesProvider).addReservation(
                                          ref
                                              .read(authRepositoryProvider)
                                              .getCurrentUser()!
                                              .uid,
                                          Reservation(
                                              name: data["name"],
                                              restaurant: reservationInfo[
                                                  "restaurantTitle"],
                                              date:
                                                  '${ref.read(confirmDateProvider)} - ${ref.read(confirmTimeProvider)}',
                                              numberOfPeople: reservationInfo[
                                                  "numberOfPeople"]));

                                      Navigator.popAndPushNamed(
                                          context, "/reservations");
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Center(
                                  child: NormalButtons(
                                      buttonText: "Change Details",
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
