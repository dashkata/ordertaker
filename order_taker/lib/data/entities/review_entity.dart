import 'package:order_taker/domain/models/review_model.dart';

class ReviewEntity {
  final String name;
  final String email;
  final String review;
  final num rating;

  ReviewEntity({
    required this.name,
    required this.review,
    required this.rating,
    required this.email,
  });

  factory ReviewEntity.fromMap({required Map data}) => ReviewEntity(
        name: data['name'],
        email: data['email'],
        review: data['review'],
        rating: data['rating'],
      );

  factory ReviewEntity.fromReview(Review review) => ReviewEntity(
        name: review.name,
        review: review.review,
        email: review.email,
        rating: review.rating,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'review': review,
        'rating': rating,
      };

  Review toReview() =>
      Review(name: name, review: review, rating: rating, email: email);
}
