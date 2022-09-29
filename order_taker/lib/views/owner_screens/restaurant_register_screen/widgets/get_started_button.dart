part of '../restaurant_register.dart';
class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(restaurantFirstNameProvider);
    final lastName = ref.watch(restaurantLastNameProvider);
    final email = ref.watch(restaurantEmailProvider);
    final password = ref.watch(restaurantPasswordProvider);
    final phoneNumber = ref.watch(restaurantPhoneProvider);
    final restaurantName = ref.watch(
      restaurantNameProvider,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: NormalButtons(
        buttonText: 'Get Started',
        buttonFunc: () async {
          await ref
              .read(
                restaurantRegisterProvider.notifier,
              )
              .signUp(
                firstName,
                lastName,
                email,
                password,
                phoneNumber,
                restaurantName,
              );
          ref
              .read(
                restaurantRegisterProvider.notifier,
              )
              .navigateToLogin();
        },
      ),
    );
  }
}
