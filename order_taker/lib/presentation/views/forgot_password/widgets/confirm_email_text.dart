part of '../forgot_password.dart';

class _ConfirmEmailText extends StatelessWidget {
  const _ConfirmEmailText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.p6,
      child: Text(
        'Confirm your email and we will send the instructions.',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
