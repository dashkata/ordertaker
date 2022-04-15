import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';

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
    return GFButton(
      borderSide: BorderSide(color: accentColor),
      onPressed: buttonFunc,
      text: buttonText,
      shape: GFButtonShape.pills,
      size: GFSize.LARGE,
      color: mainColor,
      elevation: 10,
      textStyle: GoogleFonts.roboto(
        color: accentColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
    required this.inputType,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: DoubleTextField(
          inputType: inputType,
          icon: icon,
          hintText: hintText,
          obscure: obscure),
    );
  }
}

class DoubleTextField extends StatelessWidget {
  const DoubleTextField({
    Key? key,
    required this.inputType,
    required this.icon,
    required this.hintText,
    required this.obscure,
  }) : super(key: key);

  final TextInputType inputType;
  final IconData icon;
  final String? hintText;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 10,
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              color: accentColor,
              width: 1,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          hintText: hintText,
          filled: true,
          fillColor: mainColor,
          hintStyle: GoogleFonts.roboto(
              color: accentColor, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        obscureText: obscure,
        autocorrect: false,
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
      color: mainColor,
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
      backgroundColor: mainColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              color: complementaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("Assets/garjo.jpg"),
                  radius: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Alexander Georgiev",
                  style: GoogleFonts.roboto(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
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
