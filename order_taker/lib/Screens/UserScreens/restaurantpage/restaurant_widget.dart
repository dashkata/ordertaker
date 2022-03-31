import 'package:flutter/material.dart';

class RestaurantCards extends StatelessWidget {
  const RestaurantCards({
    required this.imagePath,
    required this.restaurantName,
    required this.restaurantInfo,
    Key? key,
  }) : super(key: key);
  final String? imagePath;
  final String restaurantName;
  final String restaurantInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 100,
      child: InkWell(
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                  bottom: Radius.zero,
                ),
                child: Image.asset("Assets/$imagePath"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          restaurantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          restaurantInfo,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          color: Colors.white70,
        ),
        onTap: () {},
      ),
    );
  }
}
