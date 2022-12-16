part of '../../onboarding.dart';

class _PageOneTitle extends StatelessWidget {
  const _PageOneTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Text(
      text.welcome_owner,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
