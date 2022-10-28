class Review {
  final String name;
  final String review;
  final num rating;

  Review({
    required this.name,
    required this.review,
    required this.rating,
  });

  factory Review.fromMap({required Map data}) => Review(
        name: data['name'],
        review: data['review'],
        rating: data['rating'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'review': review,
        'rating': rating,
      };
}
