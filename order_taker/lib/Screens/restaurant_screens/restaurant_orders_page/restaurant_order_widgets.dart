import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

class OrderTitle extends StatelessWidget {
  const OrderTitle({
    required this.orderNumber,
    Key? key,
  }) : super(key: key);
  final int orderNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          "Order $orderNumber",
          style: GoogleFonts.roboto(
            color: accentColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatelessWidget {
  const OrderButton({
    required this.buttonText,
    Key? key,
  }) : super(key: key);
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GFButton(
        onPressed: () {},
        color: mainColor,
        elevation: 10,
        shape: GFButtonShape.pills,
        text: buttonText,
        textStyle: GoogleFonts.roboto(
          color: accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    required this.item,
    Key? key,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 30),
      child: Text(
        "- $item",
        style: GoogleFonts.roboto(
          color: accentColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
