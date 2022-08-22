import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/models/reservation_model.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/menu_screen_providers.dart';

import '../../../themes/themes.dart';

class MenuCard extends ConsumerWidget {
  const MenuCard({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Card(
        color: mainColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: GFListTile(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          avatar: const GFAvatar(
            // backgroundImage: AssetImage("Assets/$imagePath"),
            radius: 40,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderItem.itemTitle,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                orderItem.itemPrice,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          description: Text(
            orderItem.itemIngredients,
            style: GoogleFonts.roboto(
              color: accentColor,
              fontStyle: FontStyle.italic,
              fontSize: 10,
            ),
          ),
          onTap: () => ref
              .read(menuCardsControllerProvider.notifier)
              .addMenuCard(orderItem),
        ),
      ),
    );
  }
}

class OrderFAB extends StatelessWidget {
  const OrderFAB({
    Key? key,
    required this.reservation,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        FloatingActionButton(
          heroTag: null,
          backgroundColor: complementaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: AlertDialog(
                    title: Center(
                      child: Text(
                        "Complete the order",
                        style: GoogleFonts.roboto(
                          color: accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    content: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final menuCards =
                            ref.watch(menuCardsControllerProvider);
                        return SizedBox(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: ListView.builder(
                            itemCount: menuCards.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: const EdgeInsets.all(15),
                                elevation: 10,
                                color: complementaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${menuCards[index].itemTitle} - ${menuCards[index].itemPrice}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => ref
                                            .read(menuCardsControllerProvider
                                                .notifier)
                                            .removeMenuCard(menuCards[index]),
                                        icon:
                                            const Icon(Icons.exposure_minus_1),
                                        iconSize: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    actions: [
                      Center(
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) =>
                              GFButton(
                            onPressed: () {
                              ref
                                  .read(menuCardsControllerProvider.notifier)
                                  .completeOrder(reservation);
                              Navigator.pop(context);
                            },
                            shape: GFButtonShape.pills,
                            color: mainColor,
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            text: "Complete order",
                            textStyle: GoogleFonts.roboto(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          elevation: 10,
          child: Text(
            "Order",
            style: GoogleFonts.roboto(
              color: accentColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final menuList = ref.watch(menuCardsControllerProvider);
            return Container(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  menuList.length.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class SectionNavBar extends ConsumerWidget {
  const SectionNavBar({
    Key? key,
    required this.appetizersKey,
    required this.dishesKey,
    required this.desertsKey,
    required this.drinksKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> appetizersKey;
  final GlobalKey<State<StatefulWidget>> dishesKey;
  final GlobalKey<State<StatefulWidget>> desertsKey;
  final GlobalKey<State<StatefulWidget>> drinksKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Appetizers',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Dishes',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.icecream),
            label: 'Deserts',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast_outlined),
            label: 'Drinks',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_atm),
            label: 'Check',
            backgroundColor: mainColor,
          ),
        ],
        selectedItemColor: accentColor,
        currentIndex: ref.watch(navBarIndexProvider),
        onTap: (value) {
          ref.read(navBarIndexProvider.state).update((state) => value);
          switch (value) {
            case 0:
              if (appetizersKey.currentContext != null) {
                Scrollable.ensureVisible(appetizersKey.currentContext!);
              }
              break;
            case 1:
              if (dishesKey.currentContext != null) {
                Scrollable.ensureVisible(dishesKey.currentContext!);
              }
              break;
            case 2:
              if (desertsKey.currentContext != null) {
                Scrollable.ensureVisible(desertsKey.currentContext!);
              }
              break;
            case 3:
              if (drinksKey.currentContext != null) {
                Scrollable.ensureVisible(drinksKey.currentContext!);
              }
              break;
            case 4:
              if (appetizersKey.currentContext != null) {
                Scrollable.ensureVisible(appetizersKey.currentContext!);
              }
              ref.refresh(navBarIndexProvider);
              Navigator.pushNamed(context, '/bill');

              break;
            default:
          }
        }
        // selectedItemColor: Colors.amber[800],
        );
  }
}

class MenuSection extends StatelessWidget {
  const MenuSection({
    Key? key,
    required this.sectionKey,
    required this.sectionTitle,
  }) : super(key: key);

  final GlobalKey sectionKey;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            bottom: 10,
          ),
          child: Text(
            sectionTitle,
            style: GoogleFonts.roboto(
              color: accentColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          key: sectionKey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Material(
            borderRadius: const BorderRadius.all(
              Radius.circular(40),
            ),
            elevation: 10,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: complementaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                  MenuCard(
                    orderItem: OrderItem(
                      itemTitle: 'Салата Моцарела с авокадо',
                      itemIngredients:
                          'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                      itemPrice: '300gr: 10.49lv',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
