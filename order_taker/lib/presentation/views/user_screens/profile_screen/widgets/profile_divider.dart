part of '../profile.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(
        thickness: 0.5,
        color: accentBlackColor,
      );
}
