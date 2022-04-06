import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoButton(
          buttonText: "Overview",
          func: () {},
        ),
        InfoButton(
          buttonText: "Photos",
          func: () {},
        ),
        InfoButton(
          buttonText: "Menu",
          func: () {},
        ),
        InfoButton(
          buttonText: "Reviews",
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
    return GFButton(
      color: buttonColor,
      onPressed: func,
      type: GFButtonType.outline2x,
      text: buttonText,
    );
  }
}

class InfoDivider extends StatelessWidget {
  const InfoDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 1.5, color: Colors.grey);
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(detailDesc),
      ],
    );
  }
}
