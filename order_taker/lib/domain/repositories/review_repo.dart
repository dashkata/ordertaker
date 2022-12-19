import '../models/review_model.dart';

abstract class ReviewRepo {
  Stream<List<Review>> fetchReviews(String restaurantTitle);

  Future<void> addRestaurantReview(String restaurantTitle,
      Review review,);

}
