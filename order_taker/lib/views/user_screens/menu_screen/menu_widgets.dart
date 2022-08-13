import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/controller_providers.dart';

import '../../../themes/themes.dart';

class MenuCard extends ConsumerWidget {
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
          onTap: () {
            ref.read(menuCardsControllerProvider.notifier).addMenuCard(this);
          },
        ),
      ),
    );
  }
}
