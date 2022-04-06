import 'package:flutter/material.dart';
import 'package:order_taker/Screens/project_widgets.dart';

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
                  hintText: "Enter your full name",
                  icon: Icons.person,
                  obscure: false,
                  inputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextFields(
                  hintText: "Enter your email",
                  icon: Icons.mail,
                  obscure: false,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextFields(
                  hintText: "Enter your password",
                  icon: Icons.lock,
                  obscure: true,
                  inputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextFields(
                  hintText: "Enter your phone number",
                  icon: Icons.phone,
                  obscure: false,
                  inputType: TextInputType.number,
                ),
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
