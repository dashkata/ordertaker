import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/reservation_screen_providers.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/user_screens/reservations_screen/widget/reservation_card.dart';

import '../../project_widgets.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: appBarColor),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: Consumer(
                builder: (context, ref, child) {
                  final AsyncValue<List<Reservation>> reservations =
                      ref.watch(fetchReservationProvider);
                  return reservations.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ReservationCard(reservation: data[index]),
                    ),
                    error: (e, s) => Text(e.toString()),
                    loading: () => const LoadingIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
