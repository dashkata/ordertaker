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
          if (firstName != '' &&
              lastName != '' &&
              email != '' &&
              password != '' &&
              phoneNumber != '' &&
              restaurantName != '') {
            await ref
                .read(
                  restaurantRegisterControllerProvider.notifier,
                )
                .signUp(
                  firstName,
                  lastName,
                  email,
                  password,
                  phoneNumber,
                  restaurantName,
                )
                .then(
                  (value) => ref
                      .read(
                        restaurantRegisterControllerProvider.notifier,
                      )
                      .navigateToLogin(),
                )
                .catchError(
                  (e) => showDialog(
                    context: context,
                    builder: (_) =>
                        ErrorAlertDialog(errorMessage: e.toString()),
                  ),
                );
          } else {
            await showDialog(
              context: context,
              builder: (_) => const ErrorAlertDialog(
                errorMessage: 'Please enter text in all fields!',
              ),
            );
          }
        },
      ),
    );
  }
}
