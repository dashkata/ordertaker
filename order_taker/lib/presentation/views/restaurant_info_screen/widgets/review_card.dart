part of '../restaurant_info.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({required this.review, Key? key}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) => Padding(
        padding: PaddingManager.p4,
        child: Card(
          shape: Styles.buildRoundedBorder(40),
          color: complementaryColor,
          elevation: 5,
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, child) =>
                    ref.watch(reviewPhotoProvider(review.email)).when(
                          data: (photoURL) => Padding(
                            padding: PaddingManager.p5,
                            child: photoURL != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(photoURL),
                                    maxRadius: 35,
                                  )
                                : const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/noavatar.png'),
                                    maxRadius: 35,
                                  ),
                          ),
                          error: (e, s) => ErrorAlertDialog(
                            errorMessage: e.toString(),
                          ),
                          loading: CustomProgressIndicator.new,
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
                    ReadMoreText(
                      review.review,
                      style: Theme.of(context).textTheme.headline6,
                      trimLength: 50,
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
        ),
      );
}
