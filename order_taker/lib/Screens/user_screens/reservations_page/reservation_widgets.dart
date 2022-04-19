import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

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
      padding: const EdgeInsets.all(15),
      child: Card(
        color: complementaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            GFListTile(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              avatar: GFAvatar(
                backgroundImage: AssetImage("Assets/$imagePath"),
                radius: 40,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              description: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                    onPressed: () {
                      //Remove the card with the current index
                    },
                    elevation: 10,
                    shape: GFButtonShape.pills,
                    color: mainColor,
                    child: Text(
                      "Cancel reservation",
                      style: GoogleFonts.roboto(
                        color: accentColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
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
