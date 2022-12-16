part of '../../onboarding.dart';

class _PageTwoTitle extends StatelessWidget {
  const _PageTwoTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: Text(
          text.details_owner,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
