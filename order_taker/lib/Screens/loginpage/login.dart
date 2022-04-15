import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/LoginPage/login_widgets.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundWidget(),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                      child: Text(
                        "Welcome",
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
                      height: 420,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const TextFields(
                            hintText: "Email",
                            icon: Icons.email,
                            obscure: false,
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30),
                          const TextFields(
                            hintText: "Password",
                            icon: Icons.password,
                            obscure: true,
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          NormalButtons(buttonText: "Login", buttonFunc: () {}),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LoginText(text: "Don't have an Account?"),
                              TextButton(
                                onPressed: () {},
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
