import 'package:flutter/material.dart';
import '../../../../Themes/themes.dart';
import '../../../../models/menu_item_model.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/style_manager.dart';
import 'menu_card.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({
    required this.sectionKey,
    required this.sectionTitle,
    Key? key,
  }) : super(key: key);

  final GlobalKey sectionKey;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: PaddingManager.p6,
            key: sectionKey,
            child: Text(
              sectionTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
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
                        itemTitle: 'Салата Моцарела с авокадодддд',
                        itemIngredients:
                            'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                        itemPrice: '300gr: 10.49lv',
                      ),
                    ),
                    MenuCard(
                      orderItem: OrderItem(
                        itemTitle: 'Салата Моцарела с авокадоддеееее',
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
