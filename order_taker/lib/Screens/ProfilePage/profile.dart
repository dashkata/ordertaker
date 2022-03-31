import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfilePageWidgets(
                    changeButton: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change avatar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    userData: const GFAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                      ),
                      size: GFSize.LARGE,
                    ),
                  ),
                  ProfilePageWidgets(
                    changeButton: GFButton(
                      onPressed: () {},
                      text: "Change email address",
                      size: GFSize.LARGE,
                      color: buttonColor,
                    ),
                    userData: const TextFields(
                      hintText: "User's email",
                      icon: Icons.email,
                      obscure: false,
                    ),
                  ),
                  ProfilePageWidgets(
                    changeButton: GFButton(
                      onPressed: () {},
                      text: "Change password",
                      size: GFSize.LARGE,
                      color: buttonColor,
                    ),
                    userData: const TextFields(
                      hintText: "Enter new passowrd",
                      icon: Icons.password,
                      obscure: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          changeButton,
        ],
      ),
    );
  }
}
