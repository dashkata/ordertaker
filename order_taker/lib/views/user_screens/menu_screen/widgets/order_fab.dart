import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import '../../../../Themes/themes.dart';
import '../../../../models/reservation_model.dart';
import '../../../../providers/controller_providers.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderFAB extends StatelessWidget {
  const OrderFAB({
    Key? key,
    required this.reservation,
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
            return Container(
              height: 20,
              width: 20,
              decoration: Styles.buildBoxDecoration(
                20,
                Colors.red,
              ),
              child: Center(
                child: Text(
                  menuList.length.toString(),
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
    Key? key,
    required this.reservation,
  }) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) =>
            GFButton(
          onPressed: () => ref
              .read(menuCardsControllerProvider.notifier)
              .completeOrder(reservation),
          shape: GFButtonShape.pills,
          color: mainColor,
          elevation: 10,
          padding: PaddingManager.p10,
          text: text.complete_order,
          textStyle: Theme.of(context).textTheme.headline3,
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
      height: double.maxFinite,
      child: ListView.builder(
        itemCount: menuCards.length,
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
                    '${menuCards[index].itemTitle} - ${menuCards[index].itemPrice}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => ref
                      .read(menuCardsControllerProvider.notifier)
                      .removeMenuCard(menuCards[index]),
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
