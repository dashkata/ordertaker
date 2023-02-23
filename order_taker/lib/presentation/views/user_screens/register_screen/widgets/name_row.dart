part of '../register.dart';

class _NameRow extends ConsumerWidget {
  const _NameRow({
    required this.text,
    Key? key,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: PaddingManager.p14,
              child: DoubleTextField(
                func: (value) => ref
                    .read(registerFirstNameControllerProvider.notifier)
                    .update((state) => value),
                hintText: text.first_name,
                textInputAction: TextInputAction.next,
                icon: Icons.person,
                obscure: false,
                inputType: TextInputType.text,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: PaddingManager.p15,
              child: DoubleTextField(
                func: (value) => ref
                    .read(registerLastNameControllerProvider.notifier)
                    .update((state) => value),
                textInputAction: TextInputAction.next,
                hintText: text.last_name,
                icon: Icons.person,
                obscure: false,
                inputType: TextInputType.text,
              ),
            ),
          ),
        ],
      );
}
