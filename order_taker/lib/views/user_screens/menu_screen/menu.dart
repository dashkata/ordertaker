import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

import '../../project_widgets.dart';

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
      floatingActionButton: FloatingActionButton(
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
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "Салата Моцарела с авокадо, 300гр: 10.49 лв.",
                          style: GoogleFonts.roboto(
                            color: accentColor,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "Салата Моцарела с авокадо, 300гр: 10.49 лв.",
                          style: GoogleFonts.roboto(
                            color: accentColor,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
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

class MenuCard extends StatelessWidget {
  const MenuCard({
    required this.imagePath,
    required this.foodIngr,
    required this.foodPrice,
    required this.foodTitle,
    Key? key,
  }) : super(key: key);
  final String imagePath;
  final String foodTitle;
  final String foodPrice;
  final String foodIngr;

  @override
  Widget build(BuildContext context) {
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
          avatar: GFAvatar(
            backgroundImage: AssetImage("Assets/$imagePath"),
            radius: 40,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodTitle,
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
                foodPrice,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          description: Text(
            foodIngr,
            style: GoogleFonts.roboto(
              color: accentColor,
              fontStyle: FontStyle.italic,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
