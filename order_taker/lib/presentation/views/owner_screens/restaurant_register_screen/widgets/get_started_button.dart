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
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomButton(
        buttonText: text.get_started,
        buttonFunc: () async {
          if (firstName != '' &&
              lastName != '' &&
              email != '' &&
              password != '' &&
              phoneNumber != '' &&
              restaurantName != '') {
            await ref
                .read(
                  restaurantRegisterViewModelProvider.notifier,
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
                        restaurantRegisterViewModelProvider.notifier,
                      )
                      .navigateToLogin(),
                )
                .catchError(
                  (e) => showDialog(
                    context: context,
                    builder: (_) => ErrorAlertDialog(
                      errorMessage: e.toString(),
                    ),
                  ),
                );
          } else {
            await showDialog(
              context: context,
              builder: (_) => ErrorAlertDialog(
                errorMessage: text.enter_text_in_all_fields,
              ),
            );
          }
        },
      ),
    );
  }
}
