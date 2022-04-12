import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';

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
        color: complementaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            GFListTile(
              avatar: GFAvatar(
                backgroundImage: AssetImage("Assets/$imagePath"),
                radius: 40,
              ),
              title: Text(
                titleText,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              description: Text(
                date,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
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
