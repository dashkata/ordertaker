import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/enums/user_details.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_button.dart';

import '../../../providers/repository_providers.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../resources/route_manager.dart';
import 'profile_screen_providers.dart';

class UserProfileViewModel extends AutoDisposeAsyncNotifier<void> {
  void showPicDialog({
    required Widget title,
    required Widget content,
  }) {
    showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: title,
        content: content,
      ),
    );
  }

  Future<void> showResetPasswordDialog({
    required Widget title,
    required Widget content,
  }) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => CustomAlertDialog(
        title: title,
        content: content,
      ),
    );
  }

  Future<void> updateUserDetails({
    required String detail,
    required AppLocalizations text,
    required UserDetails detailType,
    required AutoDisposeStateProvider<bool> changeProvider,
  }) async {
    final newDetail = ref.watch(changeControllerProvider);
    if (ref.watch(changeProvider)) {
      if (detail != newDetail && newDetail != '') {
        switch (detailType) {
          case UserDetails.name:
            state = const AsyncLoading();
            state = await AsyncValue.guard(
              () => ref
                  .read(authRepositoryProvider)
                  .updateUserName(name: newDetail),
            );
            break;
          case UserDetails.email:
            await showDialog(
              context: navigatorKey.currentState!.context,
              builder: (BuildContext context) => CustomAlertDialog(
                title: Text(
                  '${text.email_changed_to}: $newDetail.'
                  '\n'
                  '${text.verify_email}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                content: CustomButton(
                  buttonFunc: () async {
                    state = const AsyncLoading();

                    state = await AsyncValue.guard(
                      () => ref
                          .read(authRepositoryProvider)
                          .updateEmail(email: newDetail),
                    );

                    await ref.read(authRepositoryProvider).signOut();
                    navigatorKey.currentState!.pop();
                    await navigatorKey.currentState!
                        .pushReplacementNamed(Routes.auth);
                  },
                  buttonText: 'OK',
                ),
              ),
            );

            break;
          case UserDetails.password:
            state = const AsyncLoading();
            state = await AsyncValue.guard(
              () => ref.read(authRepositoryProvider).updatePassword(
                    passowrd: newDetail,
                  ),
            );
            break;
          case UserDetails.mobileNumber:
            state = const AsyncLoading();
            state = await AsyncValue.guard(
              () => ref.read(userRepositoryProvider).setMobileNumber(
                    ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                    newDetail,
                  ),
            );
            break;
        }
      }
    }
    ref.invalidate(changeControllerProvider);
    ref
        .read(changeProvider.notifier)
        .update((state) => !ref.read(changeProvider));
  }

  Future<void> changeProfileImage({
    required ImageTypes imageType,
  }) async {
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
      navigatorKey.currentState!.pop();
      state = const AsyncLoading();
      final imageURL = await ref
          .read(storageRepositoryProvider)
          .uploadProfilePic(
            photoFile: File(image.path),
            email: ref.read(authRepositoryProvider).getCurrentUser()!.email!,
          );

      state = await AsyncValue.guard(
        () => ref
            .read(authRepositoryProvider)
            .updateProfilePic(photoURL: imageURL),
      );
    }
  }

  Future<void> registerAccount({
    required String email,
    required String password,
  }) async {
    final restaurantTitle =
        await ref.read(restaurantRepositoryProvider).fetchRestaurantTitle(
              ref.read(authRepositoryProvider).getCurrentUser()!.uid,
            );
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).adminSignUp(
          email: email,
          password: password,
          restaurantTitle: restaurantTitle,
        );
    state = await AsyncValue.guard(
      () => ref.read(restaurantRepositoryProvider).setRestaurantEmail(
            email,
            ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          ),
    );
    scaffoldKey.currentState!.showSnackBar(
      const SnackBar(content: Text('Restaurant account added sucessfully')),
    );
  }

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
