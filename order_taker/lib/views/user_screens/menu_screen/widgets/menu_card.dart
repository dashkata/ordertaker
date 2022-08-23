import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';

import '../../../../Themes/themes.dart';
import '../../../../models/menu_item_model.dart';
import '../../../../providers/controller_providers.dart';

class MenuCard extends ConsumerWidget {
  const MenuCard({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: PaddingManager.p4,
      child: Card(
        color: mainColor,
        elevation: 10,
        shape: Styles.buildRoundedBorder(40),
        child: GFListTile(
          padding: PaddingManager.p5,
          avatar: const GFAvatar(
            // backgroundImage: AssetImage("Assets/$imagePath"),
            radius: 40,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderItem.itemTitle,
                style: Styles.buildTextStyle(
                  accentColor,
                  16,
                  FontWeight.bold,
                  FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                orderItem.itemPrice,
                style: Styles.buildTextStyle(
                  accentColor,
                  15,
                  FontWeight.normal,
                  FontStyle.italic,
                ),
              ),
            ],
          ),
          description: Text(
            orderItem.itemIngredients,
            style: Styles.buildTextStyle(
              accentColor,
              10,
              FontWeight.normal,
              FontStyle.italic,
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