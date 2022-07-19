import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/reservations_provider.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

import 'reservation_widgets.dart';

class ReservationPage extends ConsumerWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(reservations_provider);
    return Scaffold(
      appBar: AppBar(backgroundColor: appBarColor),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView.builder(
              itemCount: orders.value?.length,
              itemBuilder: (context, index) {
                return orders.when(data: (order) {
                  return ReservationCard(
                    id: order[index].id,
                    titleText: order[index].restaurant,
                    date: order[index].date,
                    imagePath: order[index].imagepath,
                    numberOfPeople: order[index].numberOfPeople,
                  );
                }, error: (e, s) {
                  return const Center(
                    child: Text("An error accured"),
                  );
                }, loading: () {
                  return const CircularProgressIndicator();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
