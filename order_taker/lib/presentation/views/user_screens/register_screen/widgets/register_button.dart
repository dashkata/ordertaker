part of '../register.dart';

class _RegisterButton extends ConsumerWidget {
  const _RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(
      registerEmailControllerProvider,
    );
    final password = ref.watch(
      registerPasswordControllerProvider,
    );
    final firstName = ref.watch(
      registerFirstNameControllerProvider,
    );
    final lastName = ref.watch(
      registerLastNameControllerProvider,
    );
    final mobileNumber = ref.watch(
      registerPhoneNumberControllerProvider,
    );
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomButton(
        buttonText: text.register,
        buttonFunc: () async {
          if (email != '' &&
              password != '' &&
              firstName != '' &&
              lastName != '' &&
              mobileNumber != '') {
            await ref
                .read(
                  userRegisterViewModelProvider.notifier,
                )
                .register(
                  email: email,
                  password: password,
                  mobileNumber: mobileNumber,
                  firstName: firstName,
                  lastName: lastName,
                )
                .then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Registration successful. To verify your account, check your email inbox.',
                      ),
                    ),
                  ),
                  onError: (e) => showDialog(
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
