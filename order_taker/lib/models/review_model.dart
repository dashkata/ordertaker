class Review {
  final String name;
  final String review;
  final int stars;

  Review({
    required this.name,
    required this.review,
    required this.stars,
  });

  factory Review.fromMap({required Map data}) =>
      Review(name: data['name'], review: data['review'], stars: data['stars']);

  Map<String, dynamic> reviewToMap() => {
        'name': name,
        'review': review,
        'stars': stars,
      };
}
