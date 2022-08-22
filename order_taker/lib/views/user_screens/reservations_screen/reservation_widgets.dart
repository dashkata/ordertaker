import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:order_taker/themes/themes.dart';

import '../../../models/reservation_model.dart';
import '../../../providers/common_providers.dart';
import '../../project_widgets.dart';

class ReservationCard extends ConsumerWidget {
  const ReservationCard({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () =>
            Navigator.popAndPushNamed(context, '/menu', arguments: reservation),
        child: Card(
          color: complementaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              GFListTile(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                avatar: Consumer(builder: (context, ref, child) {
                  AsyncValue restaurantPic = ref
                      .watch(restaurantPictureProvider(reservation.restaurant));
                  return restaurantPic.when(
                      data: (imageUrl) => CachedNetworkImage(
                          imageUrl: restaurantPic.value,
                          imageBuilder: (context, url) => GFAvatar(
                                backgroundImage: url,
                                radius: 40,
                              )),
                      error: (e, s) => GFToast.showToast(e.toString(), context),
                      loading: () => const LoadingIndicator());
                  // return Container();
                }),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reservation.restaurant,
                      style: GoogleFonts.roboto(
                        color: accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      reservation.date,
                      style: GoogleFonts.roboto(
                        color: accentColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${reservation.numberOfPeople.toString()} people",
                      style: GoogleFonts.roboto(
                        color: accentColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                description: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      onPressed: () {
                        ref.read(userServicesProvider).deleteReservation(
                            ref
                                .read(authRepositoryProvider)
                                .getCurrentUser()!
                                .uid,
                            reservation);
                      },
                      elevation: 10,
                      shape: GFButtonShape.pills,
                      color: mainColor,
                      child: Text(
                        "Cancel reservation",
                        style: GoogleFonts.roboto(
                          color: accentColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
