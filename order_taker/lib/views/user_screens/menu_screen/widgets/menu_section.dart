import 'package:flutter/material.dart'
    '';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import 'package:order_taker/views/user_screens/menu_screen/widgets/menu_card.dart';

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
          padding: PaddingManager.p6,
          child: Text(
            sectionTitle,
            style: Theme.of(context).textTheme.headline4,
          ),
          key: sectionKey,
        ),
        Padding(
          padding: PaddingManager.p7,
          child: Material(
            borderRadius: Styles.buildBorderRadius(40),
            elevation: 10,
            child: Container(
              width: double.infinity,
              decoration: Styles.buildBoxDecoration(40, complementaryColor),
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
