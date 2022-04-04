import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/UserScreens/restaurantpage/restaurant_class.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'restaurants.dart';
import 'package:order_taker/Themes/themes.dart';

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
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
                    Row(
                      children: [
                        GFButton(
                          onPressed: () {
                            confirmation(context);
                          },
                          text: "Find a table",
                          type: GFButtonType.outline2x,
                          color: buttonColor,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class DatesColumn extends StatelessWidget {
  const DatesColumn({
    Key? key,
    required this.formatted,
  }) : super(key: key);

  final String formatted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formatted,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GFButton(
              onPressed: () {},
              text: "11:30 AM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "12:00 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "12:30 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
          ],
        ),
        Row(
          children: [
            GFButton(
              onPressed: () {},
              text: "13:00 AM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "13:30 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "14:00 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
          ],
        ),
        Row(
          children: [
            GFButton(
              onPressed: () {},
              text: "14:30 AM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "15:00 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
            const SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {},
              text: "15:30 PM",
              type: GFButtonType.outline2x,
              color: buttonColor,
            ),
          ],
        ),
      ],
    );
  }
}
