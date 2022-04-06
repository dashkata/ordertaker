import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _showRegisterChoice() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: backgroundColor,
          title: Center(
            child: Text(
              "Register as a: ",
              style: alertTextStyle,
            ),
          ),
          actions: [
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                DialogButtons(buttonText: "Customer", buttonFunc: () {}),
                DialogButtons(buttonText: "Restaurant", buttonFunc: () {}),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundWidget(),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextFields(
                hintText: "Enter your email",
                icon: Icons.email,
                obscure: false,
                inputType: TextInputType.emailAddress,
              ),
              const TextFields(
                hintText: "Enter your password",
                icon: Icons.password,
                obscure: true,
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 70,
              ),
              NormalButtons(buttonText: "Login", buttonFunc: () {}),
              const SizedBox(
                height: 35,
              ),
              NormalButtons(
                  buttonText: "Register", buttonFunc: _showRegisterChoice),
            ],
          ),
        )
      ]),
    );
  }
}
