part of '../restaurants.dart';

class _FindATableButton extends ConsumerWidget {
  const _FindATableButton({
    required this.resTitle,
    Key? key,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: NormalButtons(
        buttonText: text.find_a_table,
        buttonFunc: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDetailsDialog(context, resTitle, ref),
      ),
    );
  }
}
