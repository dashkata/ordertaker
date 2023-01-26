part of '../restaurant_register.dart';

class _BackArrowFAB extends ConsumerWidget {
  const _BackArrowFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: accentBlackColor,
        ),
      );
}
