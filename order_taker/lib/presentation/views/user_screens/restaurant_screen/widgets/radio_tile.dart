part of '../restaurants.dart';

class _RadioTile extends ConsumerWidget {
  const _RadioTile({
    required this.text,
    required this.value,
    Key? key,
  }) : super(key: key);
  final String text;
  final int value;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          value: value,
          groupValue: ref.watch(preferredLocationProvider),
          onChanged: (newValue) =>
              ref.read(preferredLocationProvider.notifier).update(
                    (state) => newValue as int,
                  ),
          title: Text(
            text,
          ),
          activeColor: complementaryColor2,
        ),
      );
}
