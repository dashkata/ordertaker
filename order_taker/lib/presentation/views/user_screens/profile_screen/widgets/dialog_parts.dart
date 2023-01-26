part of '../profile.dart';

class _DialogTitle extends StatelessWidget {
  const _DialogTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          text.choose_an_option,
          style: Theme.of(context).textTheme.headline5,
        ),
      );
}

class DialogContent extends ConsumerWidget {
  const DialogContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text(text.camera),
              onTap: () => ref
                  .read(userProfileViewModelProvider.notifier)
                  .changeProfileImage(
                    context,
                    ImageTypes.camera,
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: Text(text.browse_gallery),
              onTap: () => ref
                  .read(userProfileViewModelProvider.notifier)
                  .changeProfileImage(
                    context,
                    ImageTypes.gallery,
                  ),
            ),
          ],
        ),
      );
}
