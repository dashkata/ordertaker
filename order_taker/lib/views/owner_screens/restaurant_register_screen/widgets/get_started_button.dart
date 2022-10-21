part of '../restaurant_register.dart';
class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(restaurantRegisterFirstNameControllerProvider);
    final lastName = ref.watch(restaurantRegisterLastNameControllerProvider);
    final email = ref.watch(restaurantRegisterEmailControllerProvider);
    final password = ref.watch(restaurantRegisterPasswordControllerProvider);
    final phoneNumber = ref.watch(restaurantRegisterPhoneControllerProvider);
    final restaurantName = ref.watch(
      restaurantRegisterNameControllerProvider,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomButton(
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
