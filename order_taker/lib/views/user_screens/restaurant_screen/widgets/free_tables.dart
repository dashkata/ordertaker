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
    return AlertDialog(
      title: Text(text.available_tables),
      content: availableTables.when(
        data: (tables) => SizedBox(
          height: 300,
          width: 200,
          child: ListView.builder(
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
        ),
        error: (e, s) => Text(e.toString()),
        loading: () => const CustomProgressIndicator(),
      ),
    );
  }
}
