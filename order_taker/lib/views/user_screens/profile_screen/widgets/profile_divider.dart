import 'package:flutter/material.dart';
import '../../../../Themes/themes.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(
      thickness: 0.5,
      color: accentColor,
    );
}