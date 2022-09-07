import 'package:flutter/material.dart';

import '../../../models/reservation_model.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import 'widgets/order_list.dart';
import 'widgets/pay_button.dart';
import 'widgets/review_text_field.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: PaddingManager.p11,
                  child: OrdersList(
                    reservation: reservation,
                  ),
                ),
                const Padding(
                  padding: PaddingManager.p12,
                  child: ReviewTextField(),
                ),
                const PayButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
