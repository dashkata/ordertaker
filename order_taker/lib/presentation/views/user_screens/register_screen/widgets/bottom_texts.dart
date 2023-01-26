part of '../register.dart';

class _BottomTexts extends ConsumerWidget {
  const _BottomTexts({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.already_a_member,
                style: Theme.of(context).textTheme.headline3,
              ),
              TextButton(
                onPressed: () => ref
                    .read(userRegisterViewModelProvider.notifier)
                    .navigateToLogin(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  text.login,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.or,
                style: Theme.of(context).textTheme.headline3,
              ),
              TextButton(
                onPressed: () => ref
                    .read(userRegisterViewModelProvider.notifier)
                    .navigateToRestaurantRegister(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                ),
                child: Text(
                  text.click_here,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Text(
                text.to_register_a_restaurant,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      );
}
