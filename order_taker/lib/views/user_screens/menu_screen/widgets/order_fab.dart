part of '../menu.dart';

class _OrderFAB extends StatelessWidget {
  const _OrderFAB({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Consumer(
          builder: (context, ref, child) => FloatingActionButton(
            heroTag: null,
            backgroundColor: complementaryColor,
            onPressed: () =>
                ref.read(menuFunctionsProvider.notifier).showOrderFABDialog(
                      const _OrderFABContent(),
                      [
                        _OrderFABActions(reservation: reservation),
                      ],
                      const _OrderFABTitle(),
                      context,
                    ),
            elevation: 10,
            child: Text(
              text.order,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final menuList = ref.watch(menuCardsControllerProvider);
            int count = 0;
            for (final item in menuList.keys) {
              count += menuList[item]!;
            }
            return menuList.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    height: 20,
                    width: 20,
                    decoration: Styles.buildBoxDecoration(
                      20,
                      Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  );
          },
        )
      ],
    );
  }
}

class _OrderFABActions extends StatelessWidget {
  const _OrderFABActions({
    required this.reservation,
    Key? key,
  }) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            NormalButtons(
          buttonText: text.complete_order,
          buttonFunc: () => ref
              .read(menuCardsControllerProvider.notifier)
              .completeOrder(reservation),
        ),
      ),
    );
  }
}

class _OrderFABContent extends ConsumerWidget {
  const _OrderFABContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuCards = ref.watch(menuCardsControllerProvider);
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: menuCards.keys.length,
            itemBuilder: (BuildContext context, int index) => Card(
              elevation: 10,
              color: complementaryColor,
              shape: Styles.buildRoundedBorder(25),
              child: Padding(
                padding: PaddingManager.p9,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${menuCards.keys.elementAt(index).itemTitle} '
                        '- ${menuCards.keys.elementAt(index).itemPrice}'
                        '- ${menuCards.values.elementAt(index)}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => ref
                          .read(menuCardsControllerProvider.notifier)
                          .removeMenuCard(menuCards.keys.elementAt(index)),
                      icon: const Icon(
                        Icons.exposure_minus_1,
                      ),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextFields(
            hintText: 'Additional messages',
            icon: Icons.message,
            obscure: false,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            func: (value) =>
                ref.read(additionalMessagesProvider.notifier).update(
                      (state) => value,
                    ),
          )
        ],
      ),
    );
  }
}

class _OrderFABTitle extends StatelessWidget {
  const _OrderFABTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        text.complete_order,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
