// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:order_taker/domain/models/restaurant_model.dart';

class RestaurantEntity {
  final String title;
  final String description;
  final String openHours;
  final String website;
  final String phoneNumber;
  final String paymentMethods;
  final String photo;
  final String address;

  RestaurantEntity({
    required this.title,
    required this.description,
    required this.openHours,
    required this.website,
    required this.phoneNumber,
    required this.paymentMethods,
    required this.photo,
    required this.address,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'openHours': openHours,
        'website': website,
        'phoneNumber': phoneNumber,
        'paymentMethods': paymentMethods,
        'photo': photo,
        'address': address,
      };

  factory RestaurantEntity.fromMap(Map<String, dynamic> map) =>
      RestaurantEntity(
        title: map['title'] as String,
        description: map['description'] as String,
        openHours: map['openHours'] as String,
        website: map['website'] as String,
        phoneNumber: map['phoneNumber'] as String,
        paymentMethods: map['paymentMethods'] as String,
        photo: map['photo'] as String,
        address: map['address'] as String,
      );

  Restaurant toRestaurant() => Restaurant(
        title: title,
        description: description,
        openHours: openHours,
        website: website,
        phoneNumber: phoneNumber,
        paymentMethods: paymentMethods,
        photo: photo,
        address: address,
      );

  factory RestaurantEntity.fromRestaurant(Restaurant restaurant) =>
      RestaurantEntity(
        title: restaurant.title,
        description: restaurant.description,
        openHours: restaurant.openHours,
        website: restaurant.website,
        phoneNumber: restaurant.phoneNumber,
        paymentMethods: restaurant.paymentMethods,
        photo: restaurant.photo,
        address: restaurant.address,
      );
}
