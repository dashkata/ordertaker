import 'package:order_taker/domain/models/review_model.dart';

class ReviewEntity {
  final String name;
  final String? photoURL;
  final String review;
  final num rating;

  ReviewEntity({
    required this.name,
    required this.review,
    required this.rating,
    this.photoURL,
  });

  factory ReviewEntity.fromMap({required Map data}) => ReviewEntity(
        name: data['name'],
        photoURL: data['photoURL'],
        review: data['review'],
        rating: data['rating'],
      );

  factory ReviewEntity.fromReview(Review review) => ReviewEntity(
        name: review.name,
        review: review.review,
        rating: review.rating,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'photoURL': photoURL,
        'review': review,
        'rating': rating,
      };

  Review toReview() => Review(name: name, review: review, rating: rating);
}
