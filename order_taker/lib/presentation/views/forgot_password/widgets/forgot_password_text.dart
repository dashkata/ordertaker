part of '../forgot_password.dart';

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: PaddingManager.p13,
            child: Text(
              'Forgot your password?',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      );
}
