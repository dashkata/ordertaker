part of '/controllers/restaurant_screen_state_controller.dart';

class _NumberOfPeopleWidget extends ConsumerWidget {
  const _NumberOfPeopleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: PaddingManager.p2,
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: (value) => ref.read(peopleProvider.notifier).update(
                (state) => int.parse(value),
              ),
          decoration: InputDecoration(
            contentPadding: PaddingManager.p3,
            border: Styles.buildOutlineBorder(
              Colors.grey,
              20,
            ),
            helperText: text.enter_the_number_of_people,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
