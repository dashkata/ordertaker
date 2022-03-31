import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';

class DialogButtons extends StatelessWidget {
  const DialogButtons({
    Key? key,
    required this.buttonText,
    required this.buttonFunc,
  }) : super(key: key);

  final String? buttonText;
  final void Function() buttonFunc;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints(),
      child: SizedBox(
        width: 100,
        height: 30,
        child: GFButton(
          onPressed: buttonFunc,
          text: buttonText,
          shape: GFButtonShape.pills,
          size: GFSize.LARGE,
          color: buttonColor,
          fullWidthButton: true,
          elevation: 5,
        ),
      ),
    );
  }
}

class NormalButtons extends StatelessWidget {
  const NormalButtons({
    Key? key,
    required this.buttonText,
    required this.buttonFunc,
  }) : super(key: key);

  final String? buttonText;
  final void Function() buttonFunc;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints(),
      child: SizedBox(
        width: 200,
        height: 50,
        child: GFButton(
          onPressed: buttonFunc,
          text: buttonText,
          shape: GFButtonShape.pills,
          size: GFSize.LARGE,
          color: buttonColor,
          fullWidthButton: true,
          elevation: 5,
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.obscure,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: constraints(),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white60,
          ),
          obscureText: obscure,
          autocorrect: false,
        ),
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
    );
  }
}

class DrawerTab extends StatelessWidget {
  const DrawerTab({
    Key? key,
    required this.icon,
    required this.titleText,
    required this.func,
  }) : super(key: key);
  final IconData icon;
  final String titleText;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(titleText),
      onTap: func,
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appBarColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("The name of the user"),
              ],
            ),
          ),
          DrawerTab(
              icon: Icons.local_pizza,
              titleText: "Restaurants",
              func: () {
                Navigator.of(context).popAndPushNamed('/restaurants');
              }),
          DrawerTab(
            icon: Icons.edit_note,
            titleText: "Reservations",
            func: () {
              Navigator.of(context).popAndPushNamed('/reservations');
            },
          ),
          DrawerTab(
            icon: Icons.person,
            titleText: "Profile",
            func: () {
              Navigator.of(context).popAndPushNamed('/profile');
            },
          ),
          DrawerTab(
            icon: Icons.exit_to_app,
            titleText: "Sign out",
            func: () {},
          ),
        ],
      ),
    );
  }
}
