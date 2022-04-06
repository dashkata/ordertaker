import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    required this.userDetail,
    required this.buttonText,
    Key? key,
  }) : super(key: key);
  final String userDetail;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
        color: Colors.white38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userDetail,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: GFButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: backgroundColor,
                          title: Text(buttonText),
                          actions: [
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: buttonText,
                                filled: true,
                                fillColor: Colors.white60,
                              ),
                              obscureText: false,
                              autocorrect: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GFButton(
                              onPressed: () {},
                              color: buttonColor,
                              text: "Confirm changes",
                            )
                          ],
                        );
                      });
                },
                text: buttonText,
                shape: GFButtonShape.pills,
                color: buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
