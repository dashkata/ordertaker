import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/user_register_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidgetAuthPages(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                        child: Text(
                          text.register,
                          style: GoogleFonts.roboto(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: Container(
                        decoration: contentContainerDecoration,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: DoubleTextField(
                                      func: (value) => ref
                                          .read(firstNameProvider.notifier)
                                          .update((state) => value),
                                      hintText: text.first_name,
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: DoubleTextField(
                                      func: (value) => ref
                                          .read(lastNameProvider.notifier)
                                          .update((state) => value),
                                      hintText: text.last_name,
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFields(
                              func: (value) {
                                ref
                                    .read(emailProvider.notifier)
                                    .update((state) => value);
                              },
                              hintText: text.email_address,
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            TextFields(
                              func: (value) {
                                ref
                                    .read(passwordProvider.notifier)
                                    .update((state) => value);
                              },
                              hintText: text.password,
                              icon: Icons.lock,
                              obscure: true,
                              inputType: TextInputType.text,
                            ),
                            TextFields(
                              func: (value) {
                                ref
                                    .read(phoneNumberProvider.notifier)
                                    .update((state) => value);
                              },
                              hintText: text.mobile_number,
                              icon: Icons.phone,
                              obscure: false,
                              inputType: TextInputType.phone,
                            ),
                            Consumer(builder: (context, ref, child) {
                              final _email = ref.watch(emailProvider);
                              final _password = ref.watch(passwordProvider);
                              final _firstName = ref.watch(firstNameProvider);
                              final _lastName = ref.watch(lastNameProvider);
                              final _phoneNumber =
                                  ref.watch(phoneNumberProvider);
                              final _auth = ref.watch(authRepositoryProvider);
                              final _db =
                                  ref.watch(firestoreRepositoryProvider);
                              return Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: NormalButtons(
                                  buttonText: text.email_address,
                                  buttonFunc: () async {
                                    GFToast.showToast(
                                      await _auth
                                          .signUp(
                                            email: _email,
                                            password: _password,
                                          )
                                          .then((value) => _auth
                                              .getCurrentUser()!
                                              .sendEmailVerification())
                                          .then((value) => _db.setMobileNumber(
                                              _auth.getCurrentUser()!.uid,
                                              _phoneNumber))
                                          .then((value) => _db.setUserType(
                                              "Customer",
                                              _auth.getCurrentUser()!.uid))
                                          .then(
                                            (value) => _auth.updateUserName(
                                              name:
                                                  _firstName + " " + _lastName,
                                            ),
                                          ),
                                      context,
                                    );
                                    Navigator.popAndPushNamed(context, '/auth');
                                  },
                                ),
                              );
                            }),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      text.already_a_member,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, '/login');
                                      },
                                      child: Text(
                                        text.login,
                                        style: GoogleFonts.roboto(
                                          color: accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      text.or,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                          context,
                                          '/restaurant_register',
                                        );
                                      },
                                      child: Text(
                                        "click here",
                                        style: GoogleFonts.roboto(
                                          color: accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      text.to_register_a_restaurant,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
