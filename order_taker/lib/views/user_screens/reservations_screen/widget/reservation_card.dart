import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/reservation_model.dart';
import '../../../../providers/common_providers.dart';
import '../../../../providers/controller_providers.dart';
import '../../../../themes/themes.dart';
import '../../../project_widgets.dart';
import '../../../resources/padding_manager.dart';
import 'title_column.dart';

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
          child: Row(
            children: [
              Padding(
                padding: PaddingManager.p5,
                child: Consumer(
                  builder: (context, ref, child) {
                    final AsyncValue restaurantPic = ref.watch(
                      restaurantPictureProvider(reservation.restaurant),
                    );
                    return restaurantPic.when(
                      data: (imageUrl) => CachedNetworkImage(
                        imageUrl: restaurantPic.value,
                        imageBuilder: (context, url) => CircleAvatar(
                          backgroundImage: url,
                          radius: 40,
                        ),
                      ),
                      error: (e, s) => Text(
                        e.toString(),
                      ),
                      //     GFToast.showToast(
                      //   e.toString(),
                      //   context,
                      // ),
                      loading: () => const LoadingIndicator(),
                    );
                  },
                ),
              ),
              TitleColumn(
                reservation: reservation,
                text: text,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: IconButton(
                  onPressed: () => ref
                      .watch(userReservationProvider.notifier)
                      .deleteReservation(
                        reservation,
                        context,
                      ),
                  icon: const Icon(
                    Icons.cancel,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
