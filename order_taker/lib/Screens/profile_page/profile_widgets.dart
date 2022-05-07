import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
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

class ProfileListTile extends ConsumerWidget {
  const ProfileListTile({
    required this.detail,
    required this.icon,
    required this.hintText,
    required this.changeProvider,
    Key? key,
  }) : super(key: key);
  final String detail;
  final IconData icon;
  final String hintText;
  final StateProvider<bool> changeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(icon),
      title: AnimatedCrossFade(
        firstChild: Text(
          detail,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        secondChild: TextField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(
              color: accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          autocorrect: false,
        ),
        crossFadeState: ref.watch(changeProvider)
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
      trailing: GFIconButton(
        icon: const Icon(Icons.edit),
        size: GFSize.SMALL,
        type: GFButtonType.transparent,
        shape: GFIconButtonShape.pills,
        color: Colors.white,
        onPressed: () {
          ref.watch(changeProvider.state).state =
              ref.watch(changeProvider.state).state ? false : true;
        },
      ),
    );
  }
}
