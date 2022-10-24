class Restaurant {
  final String title;
  final String desc;
  final String openHours;
  final String website;
  final String phoneNumber;
  final String paymentMethods;
  final List<String> photos;
  final List<String>? reviews;

  Restaurant({
    required this.title,
    required this.desc,
    required this.openHours,
    required this.website,
    required this.phoneNumber,
    required this.paymentMethods,
    required this.photos,
    this.reviews,
  });

  factory Restaurant.fromMap(Map data) => Restaurant(
        title: data['title'],
        desc: data['description'],
        openHours: data['openHours'],
        website: data['website'],
        phoneNumber: data['phoneNumber'],
        paymentMethods: data['paymentMethods'],
        photos: List<String>.from(data['photos']),
        reviews: List<String>.from(data['reviews'] ?? []),
      );

  Map<String, dynamic> restaurantToMap() => {
        'title': title,
        'description': desc,
        'openHours': openHours,
        'website': website,
        'phoneNumber': phoneNumber,
        'paymentMethods': paymentMethods,
        'photos': photos,
      };
}
