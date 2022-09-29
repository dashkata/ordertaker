part of '../restaurant_register.dart';
class _BackArrowFAB extends ConsumerWidget {
  const _BackArrowFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => FloatingActionButton(
    onPressed: () => ref
        .read(restaurantRegisterProvider.notifier)
        .navigateToRegister(),
    backgroundColor: complementaryColor,
    child: const Icon(
      Icons.arrow_back,
      color: accentColor,
    ),
  );
}