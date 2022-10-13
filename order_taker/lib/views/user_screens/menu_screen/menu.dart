import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Themes/themes.dart';
import '../../../models/menu_item_model.dart';
import '../../../models/reservation_model.dart';
import '../../../providers/controller_providers.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/menu_screen_providers.dart';

part 'widgets/order_fab.dart';

part 'widgets/bottom_navbar.dart';

part 'widgets/menu_section.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);
  final appetizersKey = GlobalKey();
  final dishesKey = GlobalKey();
  final desertsKey = GlobalKey();
  final drinksKey = GlobalKey();

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
      bottomNavigationBar: _SectionNavBar(
        appetizersKey: appetizersKey,
        dishesKey: dishesKey,
        desertsKey: desertsKey,
        drinksKey: drinksKey,
        reservation: reservation,
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  _MenuSection(
                    sectionKey: appetizersKey,
                    sectionTitle: text.appetizers,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _MenuSection(
                    sectionKey: dishesKey,
                    sectionTitle: text.dishes,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _MenuSection(
                    sectionKey: desertsKey,
                    sectionTitle: text.deserts,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _MenuSection(
                    sectionKey: drinksKey,
                    sectionTitle: text.drinks,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
