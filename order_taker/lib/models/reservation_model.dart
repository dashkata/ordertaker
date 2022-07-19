class Reservation {
  final String restaurant;
  final String date;
  final String imagepath;
  final String id;
  final int numberOfPeople;

  Reservation({
    required this.id,
    required this.restaurant,
    required this.date,
    required this.imagepath,
    required this.numberOfPeople,
  });
}
