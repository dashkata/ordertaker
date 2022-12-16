part of '../bill.dart';

class ReviewTextField extends ConsumerWidget {
  const ReviewTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextField(
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
          onChanged: (value) =>
              ref.read(reviewMessageProvider.notifier).update((state) => value),
          autocorrect: false,
          maxLength: 200,
          maxLines: 4,
        ),
        RatingBar.builder(
          minRating: 1,
          allowHalfRating: true,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) =>
              ref.read(reviewRatingProvider.notifier).update((state) => rating),
        ),
      ],
    );
  }
}
