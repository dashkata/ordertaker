part of '../restaurants.dart';

class _FindATableButton extends ConsumerWidget {
  const _FindATableButton({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: CustomButton(
        buttonText: text.find_a_table,
        buttonFunc: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDetailsDialog(context, restaurant, ref),
      ),
    );
  }
}
