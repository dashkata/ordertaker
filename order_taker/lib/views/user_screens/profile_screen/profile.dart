import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';
import 'profile_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final _auth = ref.watch(authRepositoryProvider);
    final User user = _auth.getCurrentUser()!;
    final ImagePicker _imagePicker = ImagePicker();
    final _storage = ref.watch(storageRepositoryProvider);
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
                                          text.choose_an_option,
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
                                              title: Text(text.camera),
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
                                                      Routes.auth,
                                                    );
                                                  }
                                                });
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.browse_gallery),
                                              title: Text(text.browse_gallery),
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
                                                        Routes.auth,
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
                    hintText: text.change_name,
                    changeProvider: nameChangeProvider,
                    detailType: text.name,
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
                    hintText: text.change_mobile_number,
                    changeProvider: phoneChangeProvider,
                    detailType: text.mobile_number,
                    obscure: false,
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: user.email!,
                    icon: Icons.mail,
                    hintText: text.change_email_address,
                    detailType: text.email,
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
                    hintText: text.enter_your_new_password,
                    changeProvider: passwordChangeProvider,
                    detailType: text.password,
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
