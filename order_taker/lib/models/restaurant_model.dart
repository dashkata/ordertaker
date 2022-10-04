class Restaurant {
  final String title;
  final String desc;
  final String openHours;
  final String website;
  final String phoneNumber;
  final String paymentMethods;

  Restaurant({
    required this.title,
    required this.desc,
    required this.openHours,
    required this.website,
    required this.phoneNumber,
    required this.paymentMethods,
  });

  factory Restaurant.fromMap(Map data) => Restaurant(
        title: data['title'],
        desc: data['description'],
        openHours: data['openHours'],
        website: data['website'],
        phoneNumber: data['phoneNumber'],
        paymentMethods: data['paymentMethods'],
      );

  Map<String, dynamic> restaurantToMap() => {
        'title': title,
        'description': desc,
        'openHours': openHours,
        'website': website,
        'phoneNumber': phoneNumber,
        'paymentMethods': paymentMethods,
      };
}
