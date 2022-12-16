class Review {
  final String name;
  final String? photoURL;
  final String review;
  final num rating;

  Review({
    required this.name,
    required this.review,
    required this.rating,
    this.photoURL,
  });

  factory Review.fromMap({required Map data}) => Review(
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
