import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/resources/string_manager.dart';

import '../../../../Themes/themes.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/menu_screen_providers.dart';

class SectionNavBar extends ConsumerWidget {
  const SectionNavBar({
    Key? key,
    required this.appetizersKey,
    required this.dishesKey,
    required this.desertsKey,
    required this.drinksKey,
    required this.reservation,
  }) : super(key: key);
  final GlobalKey appetizersKey;
  final GlobalKey dishesKey;
  final GlobalKey desertsKey;
  final GlobalKey drinksKey;
  final Reservation reservation;

  void _navBarFunction(int value, WidgetRef ref, BuildContext context) {
    ref.read(navBarIndexProvider.state).update((state) => value);
    if (appetizersKey.currentContext != null &&
        dishesKey.currentContext != null &&
        desertsKey.currentContext != null &&
        drinksKey.currentContext != null &&
        appetizersKey.currentContext != null) {
      switch (value) {
        case 0:
          Scrollable.ensureVisible(appetizersKey.currentContext!);
          break;
        case 1:
          Scrollable.ensureVisible(dishesKey.currentContext!);
          break;
        case 2:
          Scrollable.ensureVisible(desertsKey.currentContext!);
          break;
        case 3:
          Scrollable.ensureVisible(drinksKey.currentContext!);
          break;
        case 4:
          Scrollable.ensureVisible(appetizersKey.currentContext!);
          ref.refresh(navBarIndexProvider);
          Navigator.pushNamed(context, '/bill', arguments: reservation);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.food_bank),
          label: StringManager.appetizers,
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_pizza),
          label: StringManager.dishes,
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.icecream),
          label: StringManager.deserts,
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.free_breakfast_outlined),
          label: StringManager.drinks,
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_atm),
          label: StringManager.check,
          backgroundColor: mainColor,
        ),
      ],
      selectedItemColor: accentColor,
      currentIndex: ref.watch(navBarIndexProvider),
      onTap: (value) => _navBarFunction(value, ref, context),
    );
  }
}
