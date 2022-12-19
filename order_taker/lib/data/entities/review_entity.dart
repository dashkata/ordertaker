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

  Map<String, dynamic> toMap() => {
        'name': name,
        'photoURL': photoURL,
        'review': review,
        'rating': rating,
      };
}
