import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.resTitle,
    required this.resDesc,
    required this.imagePath,
    Key? key,
  }) : super(key: key);
  final String resTitle;
  final String resDesc;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 30,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  image: AssetImage(
                    "Assets/$imagePath",
                  ),
                  height: 100,
                  fit: BoxFit.cover,
                )
              ],
            ),
            ListTile(
              title: Text(
                resTitle,
                style: GoogleFonts.roboto(
                    color: accentColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resDesc,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150,
                        child: GFButton(
                          onPressed: () {},
                          elevation: 10,
                          shape: GFButtonShape.pills,
                          text: "Find a Table",
                          color: mainColor,
                          textStyle: GoogleFonts.roboto(
                            color: accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              tileColor: complementaryColor,
            ),
          ],
        ),
      ),
    );
  }
}