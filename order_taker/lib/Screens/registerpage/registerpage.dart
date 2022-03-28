import 'package:flutter/material.dart';
import 'package:order_taker/Screens/customwidgets.dart';

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
          CustomWidgets.returnBackground(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidgets.textField("Enter your name", Icons.person, false),
                CustomWidgets.textField("Enter your email", Icons.mail, false),
                CustomWidgets.textField(
                    "Enter your password", Icons.lock, true),
                const SizedBox(
                  height: 70,
                ),
                CustomWidgets.button("Register", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
