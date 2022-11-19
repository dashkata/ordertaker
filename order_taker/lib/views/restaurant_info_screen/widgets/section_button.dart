part of '../restaurant_info.dart';

class _SectionButton extends ConsumerWidget {
  const _SectionButton({
    Key? key,
    required this.id,
    required this.sectionText,
  }) : super(key: key);
  final int id;
  final String sectionText;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: Column(
          children: [
            if (ref.watch(sectionIdProvider) == id)
              const Divider(
                color: Colors.black,
                thickness: 3,
              )
            else
              const SizedBox.shrink(),
            TextButton(
              onPressed: () => ref.read(sectionIdProvider.notifier).update(
                    (state) => id,
                  ),
              child: Text(
                sectionText,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      );
}
