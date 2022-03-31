import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({
    required this.titleText,
    required this.date,
    Key? key,
  }) : super(key: key);
  final String titleText;
  final String date;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: const GFAvatar(
        backgroundImage: AssetImage("Assets/PizzaDonVito.jpg"),
      ),
      titleText: titleText,
      description: Text(
        date,
        style: TextStyle(
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
      color: Colors.white60,
      onTap: () {},
    );
  }
}
