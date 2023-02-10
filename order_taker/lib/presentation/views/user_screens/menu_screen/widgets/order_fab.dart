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
                ref.read(menuViewModelProvider.notifier).showOrderFABDialog(
                      content: const _OrderFABContent(),
                      actions: [
                        _OrderFABActions(reservation: reservation),
                      ],
                      title: const _OrderFABTitle(),
                    ),
            elevation: 10,
            child: Text(
              text.order,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final menuList = ref.watch(menuOrderStateProvider);
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
            CustomButton(
          buttonText: text.complete_order,
          buttonFunc: () => ref
              .read(menuOrderStateProvider.notifier)
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
    final text = AppLocalizations.of(context)!;
    final menuCards = ref.watch(menuOrderStateProvider);
    return SingleChildScrollView(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: List.generate(
                menuCards.keys.length,
                (index) => Card(
                  elevation: 10,
                  color: complementaryColor,
                  shape: Styles.buildRoundedBorder(25),
                  child: Padding(
                    padding: PaddingManager.p9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${menuCards.keys.elementAt(index).itemTitle} '
                            '- ${menuCards.keys.elementAt(index).itemPrice}'
                            ' x${menuCards.values.elementAt(index)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref
                              .read(menuOrderStateProvider.notifier)
                              .removeMenuCard(menuCards.keys.elementAt(index)),
                          icon: const Icon(
                            Icons.exposure_minus_1,
                          ),
                          color: complementaryColor2,
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomTextField(
              hintText: text.additional_messages,
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
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
