import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/login_provider.dart';
import 'package:order_taker/screens/login_page/login_widgets.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _email = ref.watch(emailProvider);
    final _password = ref.watch(passwordProvider);

    final _auth = ref.watch(authServicesProvider);

    return Scaffold(
      body: Stack(children: [
        const BackgroundWidgetAuthPages(),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image(
                //   image: AssetImage('assets/black.png'),
                //   fit: BoxFit.cover,
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                      child: Text(
                        "Welcome",
                        style: GoogleFonts.roboto(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: complementaryColor,
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
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: contentContainerDecoration,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFields(
                            func: (value) =>
                                ref.read(emailProvider.state).state = value,
                            hintText: "Email",
                            icon: Icons.email,
                            obscure: false,
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30),
                          TextFields(
                            func: (value) =>
                                ref.read(passwordProvider.state).state = value,
                            hintText: "Password",
                            icon: Icons.password,
                            obscure: true,
                            inputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " ",
                            style: GoogleFonts.roboto(
                              color: accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 20),
                            child: NormalButtons(
                                buttonText: "Login",
                                buttonFunc: () => _auth.signIn(
                                      email: _email,
                                      password: _password,
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LoginText(text: "Don't have an Account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, '/register');
                                },
                                child: const LoginText(
                                  text: "Register",
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
