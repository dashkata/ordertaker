import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/themes/themes.dart';

import '../../project_widgets.dart';
import 'menu_widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton:
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
        FloatingActionButton(
          heroTag: null,
          backgroundColor: complementaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
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
                      final menuCards = ref.watch(menuCardsControllerProvider);
                      return SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child: ListView.builder(
                            itemCount: menuCards.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  color: complementaryColor,
                                  child: Row(
                                    children: [
                                      Text(
                                        '${menuCards[index].foodTitle} - ${menuCards[index].foodPrice}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .read(menuCardsControllerProvider
                                                  .notifier)
                                              .removeMenuCard(menuCards[index]);
                                        },
                                        icon:
                                            const Icon(Icons.exposure_minus_1),
                                        iconSize: 20,
                                      ),
                                    ],
                                  ));
                            }),
                      );
                    },
                  ),
                  actions: [
                    Center(
                      child: GFButton(
                        onPressed: () {},
                        shape: GFButtonShape.pills,
                        color: mainColor,
                        elevation: 10,
                        padding: EdgeInsets.symmetric(
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
                  ],
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
        Container(
          height: 20,
          width: 20,
          child: Center(
              child: Text(
            '0',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          )),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Appetizers',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Dishes',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.icecream),
            label: 'Deserts',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast_outlined),
            label: 'Water',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_atm),
            label: 'Check',
            backgroundColor: Colors.pink,
          ),
        ],
        // selectedItemColor: Colors.amber[800],
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 10,
                  ),
                  child: Text(
                    "Appetizers",
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      decoration: BoxDecoration(
                        color: complementaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: const [
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Салата Моцарела с авокадо",
                            foodPrice: "300gr: 10.49lv",
                            foodIngr:
                                "Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 10,
                  ),
                  child: Text(
                    "Dishes",
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      decoration: BoxDecoration(
                        color: complementaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: const [
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Салата Моцарела с авокадо",
                            foodPrice: "300gr: 10.49lv",
                            foodIngr:
                                "Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                          MenuCard(
                            imagePath: "PizzaDonVito.jpg",
                            foodTitle: "Овчарска салата",
                            foodPrice: "450 гр: 8.99 лв",
                            foodIngr:
                                "домати, краставици, лук, чушки, гъби, яйце (яйца), сирене (млечен продукт), шунка,маслини, магданоз ",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
