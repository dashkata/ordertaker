import 'package:flutter/material.dart';
import 'package:order_taker/Screens/customwidgets.dart';

class ChooseRegister extends StatelessWidget {
  const ChooseRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CustomWidgets.returnBackground(),
        SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("If you work in a restaurant: "),
                  CustomWidgets.button("Sign up as an employee"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If are a customer: ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        fontSize: 20),
                  ),
                  CustomWidgets.button("Sign up as a user"),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
