import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    required this.detailType,
    required this.userDetail,
    Key? key,
  }) : super(key: key);
  final String detailType;
  final String userDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              left: 10,
            ),
            child: Text(
              detailType,
              style: GoogleFonts.roboto(
                color: accentColor,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Text(
                userDetail,
                style: GoogleFonts.roboto(
                  color: accentColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
