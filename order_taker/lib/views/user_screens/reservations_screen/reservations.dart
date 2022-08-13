import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservation_state.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservation_widgets.dart';

import '../../project_widgets.dart';

class ReservationPage extends ConsumerStatefulWidget {
  const ReservationPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ReservationPageState();
}

class _ReservationPageState extends ConsumerState<ReservationPage> {
  @override
  void initState() {
    ref.read(reservationStateNotifierProvider.notifier).fetchReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(reservationStateNotifierProvider, (prev, ReservationState next) {
      if (next is ReservationError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.message)));
      }
    });
    return Scaffold(
      appBar: AppBar(backgroundColor: appBarColor),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(reservationStateNotifierProvider);
              if (state is ReservationLoading) {
                return const LoadingIndicator();
              } else if (state is ReservationLoaded) {
                return ListView.builder(
                  itemCount: state.reservations.length,
                  itemBuilder: (context, index) {
                    return ReservationCard(
                      reservation: state.reservations[index],
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )),
        ],
      ),
    );
  }
}
