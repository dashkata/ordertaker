import 'package:flutter/material.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/views/resources/string_manager.dart';
import 'package:order_taker/views/user_screens/menu_screen/widgets/bottom_navbar.dart';
import 'package:order_taker/views/user_screens/menu_screen/widgets/menu_section.dart';
import 'package:order_taker/views/user_screens/menu_screen/widgets/order_fab.dart';
import '../../project_widgets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final appetizersKey = GlobalKey();
  final dishesKey = GlobalKey();
  final desertsKey = GlobalKey();
  final drinksKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final reservation =
        ModalRoute.of(context)!.settings.arguments as Reservation;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: OrderFAB(
        reservation: reservation,
      ),
      bottomNavigationBar: SectionNavBar(
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
                  MenuSection(
                    sectionKey: appetizersKey,
                    sectionTitle: StringManager.appetizers,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: dishesKey,
                    sectionTitle: StringManager.dishes,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: desertsKey,
                    sectionTitle: StringManager.deserts,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: drinksKey,
                    sectionTitle: StringManager.drinks,
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
