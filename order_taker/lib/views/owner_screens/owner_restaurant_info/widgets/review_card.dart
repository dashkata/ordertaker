part of '../owner_restaurant_info.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({required this.review, Key? key}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) => Card(
        shape: Styles.buildRoundedBorder(40),
        color: complementaryColor,
        elevation: 5,
        child: Row(
          children: [
            const Padding(
              padding: PaddingManager.p5,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/PizzaDonVito.jpg'),
                maxRadius: 35,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    review.review,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  RatingBar.builder(
                    minRating: 1,
                    itemSize: 25,
                    initialRating: review.rating + .0,
                    allowHalfRating: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: complementaryColor2,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (double value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
