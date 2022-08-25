import 'package:flutter/material.dart';
import 'package:order_taker/views/user_screens/bill_screen/widgets/ReviewTextField.dart';
import 'package:order_taker/views/user_screens/bill_screen/widgets/order_list.dart';
import 'package:order_taker/views/user_screens/bill_screen/widgets/pay_button.dart';

import '../../../models/reservation_model.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';

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
