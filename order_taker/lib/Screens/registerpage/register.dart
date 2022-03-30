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
          const BackgroundWidget(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextFields(
                    hintText: "Enter your name",
                    icon: Icons.person,
                    obscure: false),
                const TextFields(
                    hintText: "Enter your email",
                    icon: Icons.mail,
                    obscure: false),
                const TextFields(
                    hintText: "Enter your password",
                    icon: Icons.lock,
                    obscure: true),
                const SizedBox(
                  height: 70,
                ),
                NormalButtons(buttonText: "Register", buttonFunc: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
