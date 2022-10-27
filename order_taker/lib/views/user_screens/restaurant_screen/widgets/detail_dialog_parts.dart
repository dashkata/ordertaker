part of '../restaurants.dart';

class _DetailsDialog extends ConsumerWidget {
  const _DetailsDialog({
    required this.restaurant,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SelectDateWidget(
            restaurant: restaurant,
          ),
          const _NumberOfPeopleWidget(),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: ref.watch(userDateProvider) != '' &&
                        ref.watch(peopleProvider) != 0
                    ? () {
                        ref
                            .read(restaurantControllerProvider.notifier)
                            .showTableDialog(
                              _TablesAlertDialog(
                                restaurantTitle: restaurant.title,
                              ),
                              context,
                            );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: complementaryColor2,
                ),
                child: Text(
                  text.confirm_reservation,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
