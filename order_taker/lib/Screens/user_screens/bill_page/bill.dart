import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

class BillPage extends StatelessWidget {
  const BillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: SingleChildScrollView(
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: complementaryColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: accentColor,
                          width: 1,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      hintText: "Write a review (optional)",
                      filled: true,
                      fillColor: mainColor,
                      hintStyle: GoogleFonts.roboto(
                          color: accentColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    autocorrect: false,
                    maxLength: 200,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: GFButton(
                    onPressed: () {},
                    shape: GFButtonShape.pills,
                    color: complementaryColor,
                    text: "Pay",
                    textStyle: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
