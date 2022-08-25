import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/profile_provider.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    required this.obscure,
    required this.detailType,
    Key? key,
  }) : super(key: key);
  final String detail;
  final IconData icon;
  final String hintText;
  final StateProvider<bool> changeProvider;
  final String detailType;
  final bool obscure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final _auth = ref.watch(authRepositoryProvider);
    final _database = ref.watch(firestoreRepositoryProvider);
    final newDetail = ref.watch(changeControllerProvider);
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
          onChanged: (value) =>
              ref.read(changeControllerProvider.state).state = value,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(
              color: accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          obscureText: obscure,
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
        onPressed: () async {
          if (ref.watch(changeProvider.state).state == true) {
            if (detail != newDetail && newDetail != "") {
              switch (detailType) {
                case "Name":
                  GFToast.showToast(
                    await _auth.updateUserName(name: newDetail),
                    context,
                    toastDuration: 5,
                  );
                  Navigator.popAndPushNamed(context, '/auth');
                  break;
                case "Email":
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: mainColor,
                          title: Text(
                            "${text.email_changed_to}: $newDetail."
                            "\n"
                            "${text.verify_email}",
                            style: GoogleFonts.roboto(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          actions: [
                            Center(
                              child: GFButton(
                                shape: GFButtonShape.pills,
                                color: complementaryColor,
                                onPressed: () async {
                                  GFToast.showToast(
                                    await _auth.updateEmail(email: newDetail),
                                    context,
                                    toastDuration: 5,
                                  );
                                  await _auth.signout();

                                  Navigator.popAndPushNamed(context, '/auth');
                                },
                                text: "OK",
                                textStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: accentColor,
                                ),
                              ),
                            )
                          ],
                        );
                      });
                  break;
                case "Mobile Number":
                  GFToast.showToast(
                    await _database.setMobileNumber(
                      _auth.getCurrentUser()!.uid,
                      newDetail,
                    ),
                    context,
                    toastDuration: 5,
                  );
                  Navigator.popAndPushNamed(context, '/auth');

                  break;
                case "Password":
                  GFToast.showToast(
                    await _auth.updatePassword(passowrd: newDetail),
                    context,
                    toastDuration: 5,
                  );

                  break;
              }
            }
            ref.watch(changeProvider.state).state = false;
          } else {
            ref.watch(changeProvider.state).state = true;
          }
        },
      ),
    );
  }
}
