import 'package:flutter/material.dart';
import '../../project_widgets.dart';
import 'menu_widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final appetizersKey = GlobalKey();
  final dishesKey = GlobalKey();
  final desertsKey = GlobalKey();
  final drinksKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: const OrderFAB(),
      bottomNavigationBar: SectionNavBar(
        appetizersKey: appetizersKey,
        dishesKey: dishesKey,
        desertsKey: desertsKey,
        drinksKey: drinksKey,
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
                    sectionTitle: 'Appetizers',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: dishesKey,
                    sectionTitle: 'Dishes',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: desertsKey,
                    sectionTitle: 'Deserts',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MenuSection(
                    sectionKey: drinksKey,
                    sectionTitle: 'Drinks',
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