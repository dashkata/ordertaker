part of '../../onboarding.dart';

class _HeaderPictureButton extends ConsumerWidget {
  const _HeaderPictureButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton(
        onPressed: () async => await ref
            .read(onBoardingViewModelProvider.notifier)
            .addRestaurantPicture(ref),
        child: Text(
          'Add restaurant header picture',
          style: Theme.of(context).textTheme.headline1,
        ),
      );
}
