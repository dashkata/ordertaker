part of '../../onboarding.dart';

class _PageOneImage extends StatelessWidget {
  const _PageOneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SvgPicture.asset(
          'assets/logoordertaker.svg',
          height: 400,
        ),
      );
}
