import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/order_model.dart';
import '../../../models/reservation_model.dart';
import '../../../themes/themes.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/bill_screen_providers.dart';

part 'widgets/order_list.dart';
part 'widgets/pay_button.dart';
part 'widgets/review_text_field.dart';

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
