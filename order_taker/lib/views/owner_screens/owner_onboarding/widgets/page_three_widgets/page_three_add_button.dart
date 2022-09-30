part of '../../onboarding.dart';

class _PageThreeButton extends ConsumerWidget {
  const _PageThreeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return NormalButtons(
      buttonText: text.add_menu_item,
      buttonFunc: () =>
          ref.read(onboardingControllerProvider.notifier).addMenuDialog(
                AlertDialog(
                  title: Center(
                    child: Text(
                      text.add_menu_item,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  content: const _AlertDialogBody(),
                ),
                context,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFields(
          hintText: text.type_menu_item,
          icon: Icons.restaurant,
          obscure: false,
          inputType: TextInputType.text,
          func: (value) => ref
              .read(onboardingControllerProvider.notifier)
              .updateTextField(ref, itemTypeProvider, value),
        ),
        TextFields(
          hintText: text.title_menu_item,
          icon: Icons.restaurant,
          obscure: false,
          inputType: TextInputType.text,
          func: (value) => ref
              .read(onboardingControllerProvider.notifier)
              .updateTextField(ref, itemTitleProvider, value),
        ),
        TextFields(
          hintText: text.ingredients_menu_item,
          icon: Icons.restaurant,
          obscure: false,
          inputType: TextInputType.text,
          func: (value) => ref
              .read(onboardingControllerProvider.notifier)
              .updateTextField(ref, itemIngredientsProvider, value),
        ),
        TextFields(
          hintText: text.price_menu_item,
          icon: Icons.restaurant,
          obscure: false,
          inputType: TextInputType.text,
          func: (value) => ref
              .read(onboardingControllerProvider.notifier)
              .updateTextField(ref, itemPriceProvider, value),
        ),
        Center(
          child: TextButton(
            onPressed: () =>
                ref.read(onboardingControllerProvider.notifier).pickItemImage(
                      context,
                      const _ImageAlertDialog(),
                    ),
            child: Text(
              'Add menu item picture',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        NormalButtons(
          buttonText: 'Submit',
          buttonFunc: () async {
            await ref.read(onboardingControllerProvider.notifier).addMenuItem(
                  OrderItem(
                    itemType: itemType,
                    itemTitle: itemTitle,
                    itemIngredients: itemIngredients,
                    itemPrice: itemPrice,
                  ),
                  'Pizza Don Vito',
                );
            Navigator.pop(context);
          },
        ),
      ],
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
            onTap: () {
              ref.read(onboardingControllerProvider.notifier).addItemImage(
                    ImageTypes.camera,
                    'Pizza Don Vito',
                    ref.read(
                      itemTitleProvider,
                    ),
                  );
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.browse_gallery),
            title: Text(text.browse_gallery),
            onTap: () {
              ref.read(onboardingControllerProvider.notifier).addItemImage(
                    ImageTypes.gallery,
                    'Pizza Don Vito',
                    ref.read(
                      itemTitleProvider,
                    ),
                  );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
