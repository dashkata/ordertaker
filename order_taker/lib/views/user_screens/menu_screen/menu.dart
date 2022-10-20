import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Themes/themes.dart';
import '../../../models/menu_item_model.dart';
import '../../../models/menu_section_model.dart';
import '../../../models/reservation_model.dart';
import '../../../providers/controller_providers.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import '../bill_screen/controllers/bill_screen_providers.dart';
import 'controllers/menu_screen_providers.dart';

part 'widgets/order_fab.dart';

part 'widgets/bottom_navbar.dart';

part 'widgets/menu_section.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: _OrderFAB(
        reservation: reservation,
      ),
      bottomNavigationBar: SectionNavBar(
        reservation: reservation,
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Consumer(
              builder: (context, ref, child) {
                final AsyncValue<List<MenuSection>> asyncMenu = ref.watch(
                  fetchMenuProvider(reservation.restaurant),
                );
                return asyncMenu.when(
                  data: (menu) => ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (_, index) => _MenuSection(
                      sectionTitle: menu[index].title,
                      menuList: menu[index].items,
                    ),
                  ),
                  error: (e, s) => Text(e.toString()),
                  loading: LoadingIndicator.new,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
