import 'package:flutter/material.dart';
import 'package:order_taker/Screens/customwidgets.dart';
import '';

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
        CustomWidgets.returnBackground(),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.textField("Enter your email", Icons.email, false),
              CustomWidgets.textField(
                  "Enter your password", Icons.password, true),
              const SizedBox(
                height: 70,
              ),
              CustomWidgets.button("Login"),
            ],
          ),
        )
      ]),
    );
  }
}
