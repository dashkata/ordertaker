import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/order_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:order_taker/presentation/views/user_screens/menu_screen/menu.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../custom_widgets/custom_remove_focus.dart';
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
    final text = AppLocalizations.of(context)!;
    return RemoveFocusDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            text.bill,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        bottomNavigationBar: SectionNavBar(
          reservation: reservation,
        ),
        backgroundColor: mainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                PayButton(
                  reservation: reservation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
