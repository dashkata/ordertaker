part of '../../onboarding.dart';

class _PageOneImage extends StatelessWidget {
  const _PageOneImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Image(
          width: 200,
          height: 200,
          image: AssetImage(
            'assets/logo.png',
          ),
        ),
      );
}
