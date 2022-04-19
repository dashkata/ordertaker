import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.5,
      color: accentColor,
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    required this.detail,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        detail,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
      ),
      leading: Icon(icon),
    );
  }
}
