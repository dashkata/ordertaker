part of '../restaurants.dart';

class _TablesAlertDialog extends ConsumerWidget {
  const _TablesAlertDialog({
    required this.restaurantTitle,
    Key? key,
  }) : super(key: key);
  final String restaurantTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, bool>> availableTables =
        ref.watch(freeTableListProvider(restaurantTitle));
    final text = AppLocalizations.of(context)!;
    return CustomAlertDialog(
      title: Center(
        child: Text(
          text.available_tables,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      content: availableTables.when(
        data: (tables) => SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: tables.length,
                itemBuilder: (context, index) => CustomButton(
                  buttonText: tables.keys.elementAt(index),
                  buttonFunc: tables.values.elementAt(index)
                      ? () => ref
                          .read(restaurantControllerProvider.notifier)
                          .navigateToConfirm(
                            restaurantTitle,
                            ref,
                            tables.keys.elementAt(index),
                          )
                      : null,
                ),
              ),
            ],
          ),
        ),
        error: (e, s) => ErrorAlertDialog(
          errorMessage: e.toString(),
        ),
        loading: () => const CustomProgressIndicator(),
      ),
    );
  }
}
