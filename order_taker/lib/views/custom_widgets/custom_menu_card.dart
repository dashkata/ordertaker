import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/menu_item_model.dart';
import '../../providers/auth_provider.dart';
import '../../themes/themes.dart';
import '../resources/padding_manager.dart';
import '../resources/route_manager.dart';
import '../resources/style_manager.dart';
import '../restaurant_screens/restaurant_menu_screen/controllers/menu_screen_providers.dart';
import '../user_screens/menu_screen/controllers/menu_screen_providers.dart';
import 'custom_button.dart';
import 'custom_progress_indicator.dart';

class MenuCard extends ConsumerWidget {
  const MenuCard({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncType = ref.watch(userTypeProvider);
    final text = AppLocalizations.of(context)!;
    return asyncType.when(
      data: (type) => Padding(
        padding: PaddingManager.p4,
        child: GestureDetector(
          onTap: type != 'Admin'
              ? () {
                  if (type == 'Customer') {
                    if (orderItem.available) {
                      ref.read(menuOrderStateProvider.notifier).addMenuCard(
                            orderItem,
                          );
                    }
                  } else {
                    ref
                        .read(restaurantMenuControllerProvider.notifier)
                        .statusDialog(
                          _StatusDialogTitle(text: text),
                          _StatusDialogContent(
                              text: text, orderItem: orderItem),
                        );
                  }
                }
              : () => ref
                  .read(restaurantMenuControllerProvider.notifier)
                  .removeItemDialog(
                    _RemoveDialogTitle(text: text),
                    _RemoveDialogContent(
                      text: text,
                      orderItem: orderItem,
                    ),
                  ),
          child: Card(
            color: orderItem.available ? complementaryColor : Colors.grey[300],
            elevation: 10,
            shape: Styles.buildRoundedBorder(40),
            child: Row(
              children: [
                Padding(
                  padding: PaddingManager.p5,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(orderItem.itemImage),
                    radius: 40,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              orderItem.itemTitle,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              ' - ',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              orderItem.itemPrice,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '(${orderItem.itemIngredients})',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${text.status}: ${orderItem.available ? text.available : text.not_available}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      error: (e, s) => Text(e.toString()),
      loading: () => const CustomProgressIndicator(),
    );
  }
}

class _StatusDialogContent extends ConsumerWidget {
  const _StatusDialogContent({
    Key? key,
    required this.text,
    required this.orderItem,
  }) : super(key: key);

  final AppLocalizations text;
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            buttonText: text.available,
            buttonFunc: () async {
              await ref
                  .read(
                    restaurantMenuControllerProvider.notifier,
                  )
                  .updateMenuItemStatus(
                    status: true,
                    item: orderItem,
                  );
              navigatorKey.currentState!.pop();
            },
          ),
          CustomButton(
            buttonText: text.not_available,
            buttonFunc: () async {
              await ref
                  .read(
                    restaurantMenuControllerProvider.notifier,
                  )
                  .updateMenuItemStatus(
                    status: false,
                    item: orderItem,
                  );
              navigatorKey.currentState!.pop();
            },
          ),
        ],
      );
}

class _StatusDialogTitle extends StatelessWidget {
  const _StatusDialogTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          text.change_status,
          style: Theme.of(context).textTheme.headline5,
        ),
      );
}

class _RemoveDialogContent extends ConsumerWidget {
  const _RemoveDialogContent({
    Key? key,
    required this.text,
    required this.orderItem,
  }) : super(key: key);

  final AppLocalizations text;
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            buttonText: text.cancel,
            buttonFunc: () => navigatorKey.currentState!.pop(),
          ),
          CustomButton(
            buttonText: text.confirm,
            buttonFunc: () async {
              await ref
                  .read(
                    restaurantMenuControllerProvider.notifier,
                  )
                  .removeMenuItem(
                    item: orderItem,
                  );
              navigatorKey.currentState!.pop();
            },
          ),
        ],
      );
}

class _RemoveDialogTitle extends StatelessWidget {
  const _RemoveDialogTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          text.change_status,
          style: Theme.of(context).textTheme.headline5,
        ),
      );
}
