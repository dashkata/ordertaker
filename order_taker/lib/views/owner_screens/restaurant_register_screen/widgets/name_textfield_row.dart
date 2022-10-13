part of '../restaurant_register.dart';

class _NameTextFieldRow extends ConsumerWidget {
  const _NameTextFieldRow({
    required this.text,
    Key? key,
  }) : super(key: key);
  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: DoubleTextField(
                textInputAction: TextInputAction.next,
                func: (value) {
                  ref
                      .read(
                        restaurantRegisterFirstNameControllerProvider.notifier,
                      )
                      .update(
                        (state) => value,
                      );
                },
                hintText: text.first_name,
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
                textInputAction: TextInputAction.next,
                func: (value) => ref
                    .read(
                      restaurantRegisterLastNameControllerProvider.notifier,
                    )
                    .update(
                      (state) => value,
                    ),
                hintText: text.last_name,
                icon: Icons.person,
                obscure: false,
                inputType: TextInputType.name,
              ),
            ),
          ),
        ],
      );
}
