import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

import '../../project_widgets.dart';

class RestaurantCards extends StatelessWidget {
  const RestaurantCards({
    required this.imagePath,
    required this.restaurantName,
    required this.restaurantInfo,
    Key? key,
  }) : super(key: key);
  final String? imagePath;
  final String restaurantName;
  final String restaurantInfo;

  void confirmation(BuildContext context, String formatedDate) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: backgroundColor,
          title: Center(
            child: Column(
              children: [
                Text(
                  "Confirm your reservation for: ",
                  style: alertTextStyle,
                ),
                Text(
                  "Pizza Don Vito",
                  style: alertTextStyle,
                ),
                Text(
                  formatedDate,
                  style: alertTextStyle,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "Number of people: ",
                    filled: true,
                    fillColor: Colors.white60,
                  ),
                  obscureText: false,
                  autocorrect: false,
                ),
              ],
            ),
          ),
          actions: [
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                DialogButtons(buttonText: "Confirm", buttonFunc: () {}),
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
                  color: iconbuttonColor,
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
    return SizedBox(
      height: 200,
      width: 100,
      child: InkWell(
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: cardColor,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                  bottom: Radius.zero,
                ),
                child: Image.asset("Assets/$imagePath"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          restaurantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          restaurantInfo,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime.now(), onConfirm: (date) {
            String formatedDate = date.toString().substring(0, 16);

            confirmation(context, formatedDate);
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
      ),
    );
  }
}
