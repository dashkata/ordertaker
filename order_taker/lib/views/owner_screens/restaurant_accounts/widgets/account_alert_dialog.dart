part of '../edit_restaurant_accounts.dart';

class _AlertDialogTitle extends StatelessWidget {
  const _AlertDialogTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Text('Add an account');
}

class _AlertDialogBody extends ConsumerWidget {
  const _AlertDialogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFields(
            hintText: 'Email address',
            icon: Icons.email,
            obscure: false,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            func: (value) =>
                ref.read(restaurantEmailControllerProvider.notifier).update(
                      (state) => value,
                    ),
          ),
          TextFields(
            hintText: 'Password',
            icon: Icons.password,
            obscure: true,
            inputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            func: (value) =>
                ref.read(restaurantPasswordControllerProvider.notifier).update(
                      (state) => value,
                    ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final email = ref.watch(restaurantEmailControllerProvider);
              final password = ref.watch(restaurantPasswordControllerProvider);
              return NormalButtons(
                buttonText: 'Confirm',
                buttonFunc: () async {
                  await ref
                      .read(editAccountsControllerProvider.notifier)
                      .registerAccount(email, password);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      );
}
