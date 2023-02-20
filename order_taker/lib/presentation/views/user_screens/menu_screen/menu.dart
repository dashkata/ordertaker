import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_menu_card.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import '../bill_screen/controllers/bill_screen_providers.dart';
import 'controllers/menu_screen_providers.dart';

part 'widgets/bottom_navbar.dart';
part 'widgets/menu_section.dart';
part 'widgets/order_fab.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: IconButton(
              onPressed: () => ref
                  .read(menuViewModelProvider.notifier)
                  .navigateToReservation(),
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          _OrderFAB(
            reservation: reservation,
          ),
        ],
      ),
      bottomNavigationBar: SectionNavBar(
        reservation: reservation,
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<List<MenuSection>> asyncMenu = ref.watch(
              menuListProvider(
                reservation.restaurant.title,
              ),
            );
            return asyncMenu.when(
              data: (menu) => SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    menu.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: _MenuSection(
                        sectionTitle: menu[index].title,
                        menuList: menu[index].items,
                      ),
                    ),
                  ),
                ),
              ),
              error: (e, s) => ErrorAlertDialog(
                errorMessage: e.toString(),
              ),
              loading: CustomProgressIndicator.new,
            );
          },
        ),
      ),
    );
  }
}
