import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/customwidgets.dart';
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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.amber[200],
          title: const Center(
            child: Text(
              "Choose a register type: ",
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
                height: 2,
              ),
            ),
          ),
          actions: [
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                DialogButtons(buttonText: "User", buttonFunc: () {}),
                DialogButtons(buttonText: "Employee", buttonFunc: () {}),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                GFIconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  color: Themes().backgroundColor,
                  size: GFSize.SMALL,
                  shape: GFIconButtonShape.circle,
                  iconSize: 15,
                  buttonBoxShadow: true,
                ),
              ],
            )
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
                  obscure: false),
              const TextFields(
                  hintText: "Enter your password",
                  icon: Icons.password,
                  obscure: true),
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
