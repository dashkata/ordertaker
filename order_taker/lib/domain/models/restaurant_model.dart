class Restaurant {
  final String title;
  final String description;
  final String openHours;
  final String website;
  final String phoneNumber;
  final String paymentMethods;
  final String photo;
  final String address;

  Restaurant({
    required this.title,
    required this.description,
    required this.openHours,
    required this.website,
    required this.phoneNumber,
    required this.paymentMethods,
    required this.photo,
    required this.address,
  });

  factory Restaurant.fromMap(Map data) => Restaurant(
        title: data['title'],
        description: data['description'],
        openHours: data['openHours'],
        website: data['website'],
        phoneNumber: data['phoneNumber'],
        paymentMethods: data['paymentMethods'],
        photo: data['photo'],
        address: data['address'],
      );

  Map<String, dynamic> restaurantToMap() => {
        'title': title,
        'description': description,
        'openHours': openHours,
        'website': website,
        'phoneNumber': phoneNumber,
        'paymentMethods': paymentMethods,
        'photo': photo,
        'address': address,
      };
}
