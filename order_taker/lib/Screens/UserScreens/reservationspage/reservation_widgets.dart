import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ReservationCard extends StatelessWidget {
  const ReservationCard({
    required this.titleText,
    required this.date,
    required this.imagePath,
    Key? key,
  }) : super(key: key);
  final String titleText;
  final String date;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: Colors.white60,
        child: Column(
          children: [
            GFListTile(
              avatar: GFAvatar(
                backgroundImage: AssetImage("Assets/$imagePath"),
              ),
              titleText: titleText,
              description: Text(
                date,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                    onPressed: () {
                      //Remove the card with the current index
                    },
                    color: Colors.orange[300] as Color,
                    child: const Text("Cancel reservation"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
