import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/providers/services_provider.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import 'package:order_taker/views/user_screens/reservations_screen/widget/title_column.dart';

class ReservationCard extends ConsumerWidget {
  const ReservationCard({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;

    return Padding(
      padding: PaddingManager.p11,
      child: GestureDetector(
        onTap: () => ref
            .read(userReservationProvider.notifier)
            .navigateToMenu(reservation),
        child: Card(
          color: complementaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              GFListTile(
                padding: PaddingManager.p5,
                avatar: Consumer(builder: (context, ref, child) {
                  AsyncValue restaurantPic = ref
                      .watch(restaurantPictureProvider(reservation.restaurant));
                  return restaurantPic.when(
                    data: (imageUrl) => CachedNetworkImage(
                      imageUrl: restaurantPic.value,
                      imageBuilder: (context, url) => GFAvatar(
                        backgroundImage: url,
                        radius: 40,
                      ),
                    ),
                    error: (e, s) => GFToast.showToast(
                      e.toString(),
                      context,
                    ),
                    loading: () => const LoadingIndicator(),
                  );
                }),
                title: TitleColumn(
                  reservation: reservation,
                  text: text,
                ),
                description: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      onPressed: () => ref
                          .read(userReservationProvider.notifier)
                          .deleteReservation(reservation),
                      elevation: 10,
                      shape: GFButtonShape.pills,
                      color: mainColor,
                      child: Text(
                        text.cancel_reservation,
                        style: Theme.of(context).textTheme.headline1,
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
