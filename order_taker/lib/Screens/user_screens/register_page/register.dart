import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
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
                          "Register",
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
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: complementaryColor,
                        ),
                        width: double.infinity,
                        height: 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: DoubleTextField(
                                      func: (value) {},
                                      hintText: "First Name",
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: DoubleTextField(
                                      func: (value) {},
                                      hintText: "Last Name",
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFields(
                              func: (value) {},
                              hintText: "Email Address",
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            TextFields(
                              func: (value) {},
                              hintText: "Password",
                              icon: Icons.lock,
                              obscure: true,
                              inputType: TextInputType.text,
                            ),
                            TextFields(
                              func: (value) {},
                              hintText: "Mobile Number",
                              icon: Icons.phone,
                              obscure: false,
                              inputType: TextInputType.number,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: NormalButtons(
                                  buttonText: "Sign up", buttonFunc: () {}),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already a Member?",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Sign in",
                                        style: GoogleFonts.roboto(
                                          color: accentColor,
                                          fontSize: 16,
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
                                      "Or",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Click here",
                                        style: GoogleFonts.roboto(
                                          color: accentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "to Register a Restaurant",
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
