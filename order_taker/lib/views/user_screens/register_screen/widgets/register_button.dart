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
          await ref
              .read(
                userRegisterProvider.notifier,
              )
              .register(
                email,
                password,
                mobileNumber,
                firstName,
                lastName,
              )
              .then(
                (value) => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Register successful',
                    ),
                  ),
                ),
                onError: (e, s) => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}
