class Restaurant {
  final String title;
  final String desc;
  final String openHours;

  Restaurant({
    required this.title,
    required this.desc,
    required this.openHours,
  });

  factory Restaurant.fromMap(Map data) => Restaurant(
        title: data['title'],
        desc: data['description'],
        openHours: data['openHours'],
      );
}
