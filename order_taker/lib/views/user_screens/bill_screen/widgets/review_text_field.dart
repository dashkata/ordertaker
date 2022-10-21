part of '../bill.dart';

class ReviewTextField extends StatelessWidget {
  const ReviewTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return TextField(
      decoration: InputDecoration(
        border: Styles.buildOutlineBorder(
          complementaryColor2,
          30,
        ),
        focusedBorder: Styles.buildOutlineBorder(
          complementaryColor2,
          30,
        ),
        hintText: text.write_a_review,
        filled: true,
        fillColor: mainColor,
        hintStyle: Theme.of(context).textTheme.headline6,
      ),
      autocorrect: false,
      maxLength: 200,
      maxLines: 4,
    );
  }
}
