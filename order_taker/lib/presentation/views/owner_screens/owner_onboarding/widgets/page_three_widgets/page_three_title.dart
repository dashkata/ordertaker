part of '../../onboarding.dart';

class _PageThreeTitle extends StatelessWidget {
  const _PageThreeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: Text(
          text.add_menu_item,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
