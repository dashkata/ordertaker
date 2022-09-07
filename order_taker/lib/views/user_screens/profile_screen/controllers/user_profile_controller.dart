import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/enums/user_details.dart';
import 'package:order_taker/repositories/auth_repository.dart';
import 'package:order_taker/repositories/firestore_repository.dart';
import 'package:order_taker/repositories/storage_repository.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../providers/profile_provider.dart';

class UserProfileNotifier extends StateNotifier<void> {
  UserProfileNotifier({
    required AuthRepository authRepository,
    required FirestoreRepository firestoreRepository,
    required StorageRepository storageRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        _storageRepository = storageRepository,
        super(null);
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;
  final FirestoreRepository _firestoreRepository;

  void showPicDialog(Widget title, Widget content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: complementaryColor,
        title: title,
        content: content,
      ),
    );
  }

  Future<void> updateUserDetails(
    WidgetRef ref,
    String detail,
    BuildContext context,
    AppLocalizations text,
    UserDetails detailType,
    StateProvider<bool> changeProvider,
  ) async {
    final newDetail = ref.watch(changeControllerProvider);
    if (ref.watch(changeProvider)) {
      if (detail != newDetail && newDetail != '') {
        switch (detailType) {
          case UserDetails.name:
            GFToast.showToast(
              await _authRepository.updateUserName(name: newDetail),
              context,
              toastDuration: 5,
            );
            await navigatorKey.currentState!.popAndPushNamed(
              Routes.auth,
            );
            break;
          case UserDetails.email:
            await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: mainColor,
                title: Text(
                  '${text.email_changed_to}: $newDetail.'
                  '\n'
                  '${text.verify_email}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                actions: [
                  Center(
                    child: GFButton(
                      shape: GFButtonShape.pills,
                      color: complementaryColor,
                      onPressed: () async {
                        GFToast.showToast(
                          await _authRepository.updateEmail(
                            email: newDetail,
                          ),
                          context,
                          toastDuration: 5,
                        );
                        await _authRepository.signout();
                        await navigatorKey.currentState!.popAndPushNamed(
                          Routes.auth,
                        );
                      },
                      text: 'OK',
                      textStyle: Theme.of(context).textTheme.headline1,
                    ),
                  )
                ],
              ),
            );
            break;
          case UserDetails.password:
            GFToast.showToast(
              await _authRepository.updatePassword(
                passowrd: newDetail,
              ),
              context,
              toastDuration: 5,
            );
            break;
          case UserDetails.mobileNumber:
            GFToast.showToast(
              await _firestoreRepository.setMobileNumber(
                _authRepository.getCurrentUser()!.uid,
                newDetail,
              ),
              context,
              toastDuration: 5,
            );
            break;
        }
      }
    }
    ref
        .read(changeProvider.notifier)
        .update((state) => !ref.read(changeProvider));
  }

  Future<void> changeProfileImage(
    BuildContext context,
    ImageTypes imageType,
  ) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image;
    switch (imageType) {
      case ImageTypes.camera:
        image = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        break;
      case ImageTypes.gallery:
        image = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        break;
    }
    if (image != null) {
      GFToast.showToast(
        await _storageRepository.uploadProfilePic(
          photoFile: File(image.path),
          email: _authRepository.getCurrentUser()!.email!,
        ),
        context,
      );
      navigatorKey.currentState!.pop();
      await navigatorKey.currentState!.popAndPushNamed(
        Routes.auth,
      );
    }
  }
}
