part of '../edit_restaurant_accounts.dart';

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
                      .read(editAccountsControllerProvider.notifier)
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
