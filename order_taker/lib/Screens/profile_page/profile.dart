import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/profile_page/profile_widgets.dart';

import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/profile_provider.dart';

import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authServicesProvider);
    final _message = ref.watch(messageProvider);

    final User user = _auth.getCurrentUser()!;

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
                        margin: const EdgeInsets.only(bottom: 50),
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
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
                              user.displayName!,
                              style: GoogleFonts.roboto(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage("Assets/garjo.jpg"),
                        radius: 60,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: user.displayName!,
                    icon: Icons.person,
                    hintText: "Change name",
                    changeProvider: nameChangeProvider,
                    detailType: "Name",
                    obscure: false,
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: "089 783 4668",
                    icon: Icons.phone,
                    hintText: "Change mobile number",
                    changeProvider: phoneChangeProvider,
                    detailType: "Mobile Number",
                    obscure: false,
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: user.email!,
                    icon: Icons.mail,
                    hintText: "Change email addresss",
                    detailType: "Email",
                    changeProvider: emailChangeProvider,
                    obscure: false,
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: "*********",
                    icon: Icons.password,
                    hintText: "Enter your new password",
                    changeProvider: passwordChangeProvider,
                    detailType: "Password",
                    obscure: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        _message,
                        style: GoogleFonts.roboto(
                          color: accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
