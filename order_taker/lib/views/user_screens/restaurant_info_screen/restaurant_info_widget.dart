import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoButton(
          buttonText: text.overview,
          func: () {},
        ),
        InfoButton(
          buttonText: text.photos,
          func: () {},
        ),
        InfoButton(
          buttonText: text.menu,
          func: () {},
        ),
        InfoButton(
          buttonText: text.reviews,
          func: () {},
        ),
      ],
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    required this.buttonText,
    required this.func,
    Key? key,
  }) : super(key: key);
  final String buttonText;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return Container();
    // return GFButton(
    //   color: complementaryColor,
    //   onPressed: func,
    //   shape: GFButtonShape.pills,
    //   text: buttonText,
    //   elevation: 5,
    //   textStyle: GoogleFonts.roboto(
    //     color: accentColor,
    //     fontWeight: FontWeight.bold,
    //   ),
    // );
  }
}

class InfoDivider extends StatelessWidget {
  const InfoDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.5,
      color: accentColor,
    );
  }
}

class DetailText extends StatelessWidget {
  const DetailText({
    required this.detailTitle,
    required this.detailDesc,
    required this.detailTitleIcon,
    Key? key,
  }) : super(key: key);
  final String detailTitle;
  final String detailDesc;
  final Icon detailTitleIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            detailTitleIcon,
            const SizedBox(width: 5),
            Text(
              detailTitle,
              style: GoogleFonts.roboto(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          detailDesc,
          style: GoogleFonts.roboto(
            color: accentColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
