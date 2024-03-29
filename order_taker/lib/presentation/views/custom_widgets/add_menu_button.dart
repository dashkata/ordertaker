import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/presentation/views/resources/route_manager.dart';

import '../owner_screens/owner_onboarding/controllers/onboarding_providers.dart';
import 'custom_alert_dialog.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class AddMenuButton extends ConsumerWidget {
  const AddMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomButton(
      buttonText: text.add_menu_item,
      buttonFunc: () =>
          ref.read(onBoardingViewModelProvider.notifier).addMenuDialog(
                alertDialog: CustomAlertDialog(
                  title: Center(
                    child: Text(
                      text.add_menu_item,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  content: const _AlertDialogBody(),
                ),
              ),
    );
  }
}

class _AlertDialogBody extends ConsumerWidget {
  const _AlertDialogBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final itemType = ref.watch(itemTypeProvider);
    final itemTitle = ref.watch(itemTitleProvider);
    final itemIngredients = ref.watch(itemIngredientsProvider);
    final itemPrice = ref.watch(itemPriceProvider);
    final itemImage = ref.watch(itemImageProvider);
    final currency = ref.watch(currencyProvider);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            hintText: text.type_menu_item,
            icon: Icons.restaurant,
            obscure: false,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            func: (value) =>
                ref.read(itemTypeProvider.notifier).update((state) => value),
          ),
          CustomTextField(
            hintText: text.title_menu_item,
            icon: Icons.restaurant,
            obscure: false,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            func: (value) =>
                ref.read(itemTitleProvider.notifier).update((state) => value),
          ),
          CustomTextField(
            hintText: text.ingredients_menu_item,
            icon: Icons.restaurant,
            obscure: false,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            func: (value) => ref
                .read(itemIngredientsProvider.notifier)
                .update((state) => value),
          ),
          CustomTextField(
            hintText: text.price_menu_item,
            icon: Icons.restaurant,
            obscure: false,
            textInputAction: TextInputAction.done,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            suffix: ref.read(itemPriceProvider).isNotEmpty
                ? DropdownButton(
                    value: ref.watch(currencyProvider),
                    items: ref
                        .read(onBoardingViewModelProvider.notifier)
                        .dropDownItems
                        .map(
                          (String items) => DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => ref
                        .read(currencyProvider.notifier)
                        .update((state) => value.toString()),
                  )
                : null,
            func: (value) =>
                ref.read(itemPriceProvider.notifier).update((state) => value),
          ),
          Center(
            child: TextButton(
              onPressed: () async => await ref
                  .read(onBoardingViewModelProvider.notifier)
                  .pickItemImage(
                    content: const _ImageAlertDialog(),
                  ),
              child: Text(
                text.picture_menu_item,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          CustomButton(
            buttonText: text.submit,
            buttonFunc: () async {
              await ref.read(onBoardingViewModelProvider.notifier).addMenuItem(
                    orderItem: OrderItem(
                      itemType: itemType,
                      itemTitle: itemTitle,
                      itemIngredients: itemIngredients,
                      itemPrice: itemPrice,
                      itemCurrency: currency,
                      itemImage: itemImage,
                      available: true,
                    ),
                  );
              navigatorKey.currentState!.pop();
            },
          ),
        ],
      ),
    );
  }
}

class _ImageAlertDialog extends ConsumerWidget {
  const _ImageAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: ListBody(
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: Text(text.camera),
            onTap: () async {
              await ref.read(onBoardingViewModelProvider.notifier).addItemImage(
                    imageTypes: ImageTypes.camera,
                    ref: ref,
                    itemName: ref.read(
                      itemTitleProvider,
                    ),
                  );
              navigatorKey.currentState!.pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.browse_gallery),
            title: Text(text.browse_gallery),
            onTap: () async {
              await ref.read(onBoardingViewModelProvider.notifier).addItemImage(
                    imageTypes: ImageTypes.gallery,
                    ref: ref,
                    itemName: ref.read(
                      itemTitleProvider,
                    ),
                  );
              navigatorKey.currentState!.pop();
            },
          ),
        ],
      ),
    );
  }
}
