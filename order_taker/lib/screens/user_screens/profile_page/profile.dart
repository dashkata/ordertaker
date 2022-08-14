import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/profile_provider.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/screens/user_screens/profile_page/profile_widgets.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authServicesProvider);
    final User user = _auth.getCurrentUser()!;
    final ImagePicker _imagePicker = ImagePicker();
    final _storage = ref.watch(storageProvider);
    AsyncValue _mobileNumber = ref.watch(phoneNumberProvider);
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
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const ProfilePicture(
                            radius: 60,
                          ),
                          GFIconButton(
                            color: GFColors.WHITE,
                            size: GFSize.SMALL,
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                            shape: GFIconButtonShape.circle,
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: complementaryColor,
                                      title: Center(
                                        child: (Text(
                                          "Choose an option",
                                          style: GoogleFonts.roboto(
                                            color: accentColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title: const Text("Camera"),
                                              onTap: () async {
                                                await _imagePicker
                                                    .pickImage(
                                                  source: ImageSource.camera,
                                                )
                                                    .then((value) async {
                                                  if (value != null) {
                                                    GFToast.showToast(
                                                      await _storage
                                                          .uploadProfilePic(
                                                        photoFile:
                                                            File(value.path),
                                                        email: _auth
                                                            .getCurrentUser()!
                                                            .email!,
                                                      ),
                                                      context,
                                                    );
                                                    Navigator.pop(context);
                                                    Navigator.popAndPushNamed(
                                                      context,
                                                      '/auth',
                                                    );
                                                  }
                                                });
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.browse_gallery),
                                              title:
                                                  const Text("Browse gallery"),
                                              onTap: () async {
                                                await _imagePicker
                                                    .pickImage(
                                                  source: ImageSource.gallery,
                                                )
                                                    .then(
                                                  (value) async {
                                                    if (value != null) {
                                                      GFToast.showToast(
                                                          await _storage
                                                              .uploadProfilePic(
                                                            photoFile: File(
                                                                value.path),
                                                            email: _auth
                                                                .getCurrentUser()!
                                                                .email!,
                                                          ),
                                                          context);
                                                      Navigator.pop(context);
                                                      Navigator.popAndPushNamed(
                                                        context,
                                                        '/auth',
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
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
                    detail: _mobileNumber.when(
                        data: (mobileNumber) => mobileNumber,
                        error: (e, s) => "Mobile number not set",
                        loading: () => " "),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
