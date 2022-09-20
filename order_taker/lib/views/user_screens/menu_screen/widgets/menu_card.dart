import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Themes/themes.dart';
import '../../../../models/menu_item_model.dart';
import '../../../../providers/controller_providers.dart';
import '../../../resources/padding_manager.dart';
import '../../../resources/style_manager.dart';

class MenuCard extends ConsumerWidget {
  const MenuCard({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: PaddingManager.p4,
        child: GestureDetector(
          onTap: () =>
              ref.read(menuCardsControllerProvider.notifier).addMenuCard(
                    orderItem,
                  ),
          child: Card(
            color: mainColor,
            elevation: 10,
            shape: Styles.buildRoundedBorder(40),
            child: Row(
              children: [
                const Padding(
                  padding: PaddingManager.p5,
                  child: CircleAvatar(
                    // backgroundImage: AssetImage("Assets/$imagePath"),
                    radius: 40,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItem.itemTitle,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          orderItem.itemPrice,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          orderItem.itemIngredients,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
