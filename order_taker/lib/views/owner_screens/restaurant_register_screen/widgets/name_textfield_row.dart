part of '../restaurant_register.dart';

class _NameTextFieldRow extends ConsumerWidget {
  const _NameTextFieldRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: DoubleTextField(
            func: (value) {
              ref
                  .read(
                restaurantRegisterProvider.notifier,
              )
                  .updateText(
                restaurantFirstNameProvider,
                value,
              );
            },
            hintText: 'First Name',
            icon: Icons.person,
            obscure: false,
            inputType: TextInputType.name,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: DoubleTextField(
            func: (value) => ref
                .read(
              restaurantRegisterProvider.notifier,
            )
                .updateText(
              restaurantLastNameProvider,
              value,
            ),
            hintText: 'Last Name',
            icon: Icons.person,
            obscure: false,
            inputType: TextInputType.name,
          ),
        ),
      ),
    ],
  );
}