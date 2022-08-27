import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';

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
      padding: PaddingManager.p16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingManager.p17,
            child: Text(
              detailType,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Material(
            elevation: 10,
            borderRadius: Styles.buildBorderRadius(40),
            child: Container(
              decoration: Styles.buildBoxDecoration(
                40,
                mainColor,
              ),
              padding: PaddingManager.p18,
              child: Text(
                userDetail,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
