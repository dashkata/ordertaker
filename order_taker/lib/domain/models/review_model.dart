class Review {
  final String name;
  final String email;
  final String review;
  final num rating;

  Review({
    required this.name,
    required this.review,
    required this.rating,
    required this.email,
  });

  factory Review.fromMap({required Map data}) => Review(
        name: data['name'],
        email: data['email'],
        review: data['review'],
        rating: data['rating'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'review': review,
        'rating': rating,
      };
}
