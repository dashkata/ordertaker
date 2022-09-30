part of '../../onboarding.dart';

class _PageOneImage extends StatelessWidget {
  const _PageOneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
      child: Image.asset(
        'assets/Logo2.0.png',
        height: 400,
      ),
    );
}
