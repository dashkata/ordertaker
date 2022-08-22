import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/models/menu_item_model.dart';
import 'package:order_taker/providers/controller_providers.dart';

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
