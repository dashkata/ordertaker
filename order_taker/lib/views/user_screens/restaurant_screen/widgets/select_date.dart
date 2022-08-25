part of '/controllers/restaurant_screen_state_controller.dart';

class _SelectDateWidget extends ConsumerWidget {
  const _SelectDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          border: Styles.buildOutlineBorder(
            Colors.grey,
            20,
          ),
          focusedBorder: Styles.buildOutlineBorder(
            Colors.grey,
            20,
          ),
          contentPadding: PaddingManager.p3,
          helperText: "Select a date for your reservation",
          hintText: ref.watch(userDateProvider),
        ),
        onTap: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDateTimePicker(context, ref),
      ),
    );
  }
}
