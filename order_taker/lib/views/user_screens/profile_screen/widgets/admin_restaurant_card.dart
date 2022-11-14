part of '../profile.dart';

class _AdminRestaurantCard extends ConsumerWidget {
  const _AdminRestaurantCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final restaurantEmail = ref.watch(restaurantEmailProvider);
    return restaurantEmail.when(
      data: (email) => email != null
          ? Card(
              elevation: 10,
              shape: Styles.buildRoundedBorder(40),
              child: Column(
                children: [
                  Text(
                    email,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  CustomButton(
                    buttonText: 'Reset password',
                    buttonFunc: () async {
                      await ref
                          .read(authRepositoryProvider)
                          .sendPasswordResetLink(
                            email,
                          );
                      await ref
                          .read(userProfileProvider.notifier)
                          .showResetPasswordDialog(
                            Text(
                              'Reset password',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              'A password reset link has been sent to $email',
                            ),
                          );
                    },
                  ),
                ],
              ),
            )
          : CustomButton(
              buttonText: text.add_account,
              buttonFunc: () => showDialog(
                context: context,
                builder: (context) => const CustomAlertDialog(
                  title: _AlertDialogTitle(),
                  content: _AlertDialogBody(),
                ),
              ),
            ),
      error: (e, s) => ErrorAlertDialog(
        errorMessage: e.toString(),
      ),
      loading: () => const CustomProgressIndicator(),
    );
  }
}

class _AlertDialogTitle extends StatelessWidget {
  const _AlertDialogTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        text.add_account,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

class _AlertDialogBody extends ConsumerWidget {
  const _AlertDialogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          hintText: text.email_address,
          icon: Icons.email,
          obscure: false,
          inputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          func: (value) =>
              ref.read(restaurantEmailControllerProvider.notifier).update(
                    (state) => value,
                  ),
        ),
        CustomTextField(
          hintText: text.password,
          icon: Icons.password,
          obscure: true,
          inputType: TextInputType.text,
          textInputAction: TextInputAction.done,
          func: (value) =>
              ref.read(restaurantPasswordControllerProvider.notifier).update(
                    (state) => value,
                  ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Consumer(
            builder: (context, ref, child) {
              final email = ref.watch(restaurantEmailControllerProvider);
              final password = ref.watch(restaurantPasswordControllerProvider);
              return CustomButton(
                buttonText: text.submit,
                buttonFunc: () async {
                  await ref
                      .read(userProfileProvider.notifier)
                      .registerAccount(email, password);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
