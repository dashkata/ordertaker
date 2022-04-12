import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';
import 'profile_widgets.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 50),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: complementaryColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(200),
                            bottomLeft: Radius.circular(200),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: Text(
                              "Alexander Georgiev",
                              style: GoogleFonts.roboto(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage("Assets/garjo.jpg"),
                        radius: 60,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text("Alexander Georgiev",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor)),
                    leading: Icon(Icons.person),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: accentColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text("089 783 4668",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor)),
                    leading: Icon(Icons.phone),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: accentColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text("alexandur04@abv.bg",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor)),
                    leading: Icon(Icons.mail),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: accentColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text("**********",
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor)),
                    leading: Icon(
                      Icons.password,
                    ),
                    trailing: GFButton(
                      elevation: 10,
                      shape: GFButtonShape.pills,
                      child: Text(
                        "Change Password",
                        style: GoogleFonts.roboto(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: complementaryColor,
                      onPressed: () {},
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: accentColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: GFButton(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      elevation: 10,
                      shape: GFButtonShape.pills,
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: complementaryColor,
                      onPressed: () {},
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
