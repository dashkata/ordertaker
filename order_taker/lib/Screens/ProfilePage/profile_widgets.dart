import 'package:flutter/material.dart';

class ProfilePageWidgets extends StatelessWidget {
  const ProfilePageWidgets({
    required this.userData,
    required this.changeButton,
    Key? key,
  }) : super(key: key);
  final Widget userData;
  final Widget changeButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          userData,
          SizedBox(height: 10),
          changeButton,
        ],
      ),
    );
  }
}
