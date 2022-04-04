import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurant_widget.dart';
import 'package:order_taker/Themes/themes.dart';

void confirmation(BuildContext context) {
  DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE, MMMM d, y');
  final String formatted = formatter.format(now);
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: backgroundColor,
        title: Center(
          child: DatesColumn(formatted: formatted),
        ),
        actions: [
          OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              GFIconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
                color: iconbuttonColor,
                size: GFSize.SMALL,
                shape: GFIconButtonShape.circle,
                iconSize: 15,
                buttonBoxShadow: true,
              ),
              GFIconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
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
