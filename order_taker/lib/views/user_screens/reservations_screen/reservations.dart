import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/reservation_screen_providers.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservation_widgets.dart';

import '../../project_widgets.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appBarColor),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Consumer(builder: (context, ref, child) {
              AsyncValue<List<Reservation>> reservations =
                  ref.watch(fetchReservationProvider);
              return reservations.when(
                  data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ReservationCard(reservation: data[index])),
                  error: (e, s) => GFToast.showToast(e.toString(), context),
                  loading: () => const LoadingIndicator());
            }),
          ),
        ],
      ),
    );
  }
}
