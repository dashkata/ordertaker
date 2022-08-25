import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/views/resources/style_manager.dart';

class FindATableButton extends ConsumerWidget {
  const FindATableButton({
    Key? key,
    required this.resTitle,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 150,
      child: GFButton(
        onPressed: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDetailsDialog(context, resTitle, ref),
        elevation: 10,
        shape: GFButtonShape.pills,
        text: "Find a Table",
        color: mainColor,
        textStyle: Styles.buildTextStyle(
          accentColor,
          15,
          FontWeight.bold,
          FontStyle.normal,
        ),
      ),
    );
  }
}
