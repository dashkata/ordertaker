part of '../owner_restaurant_info.dart';

class _ReviewsSection extends ConsumerWidget {
  const _ReviewsSection({
    required this.restaurant,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final asyncReviews = ref.watch(
      restaurantReviewsProvider(
        restaurant.title,
      ),
    );
    return Expanded(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  text.reviews,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              asyncReviews.when(
                data: (reviews) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ReviewCard(review: reviews[index]),
                ),
                error: (e, s) => ErrorAlertDialog(errorMessage: e.toString()),
                loading: () => const CustomProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
