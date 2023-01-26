import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/storage_repository.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/enums/user_details.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import 'profile_screen_providers.dart';

class UserProfileViewModel extends StateNotifier<void> {
  UserProfileViewModel({
    required AuthRepository authRepository,
    required UserRepo userRepo,
    required RestaurantRepo restaurantRepo,
    required StorageRepository storageRepository,
  })  : _authRepository = authRepository,
        _userRepo = userRepo,
        _restaurantRepo = restaurantRepo,
        _storageRepository = storageRepository,
        super(null);
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;
  final UserRepo _userRepo;
  final RestaurantRepo _restaurantRepo;

  void showPicDialog(Widget title, Widget content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        title: title,
        content: content,
      ),
    );
  }

  Future<void> showResetPasswordDialog(Widget title, Widget content) async {
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => CustomAlertDialog(
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
    AutoDisposeStateProvider<bool> changeProvider,
  ) async {
    final newDetail = ref.watch(changeControllerProvider);
    if (ref.watch(changeProvider)) {
      if (detail != newDetail && newDetail != '') {
        switch (detailType) {
          case UserDetails.name:
            await _authRepository.updateUserName(name: newDetail);
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
                  // Center(
                  //   child: GFButton(
                  //     shape: GFButtonShape.pills,
                  //     color: complementaryColor,
                  //     onPressed: () async {
                  //       GFToast.showToast(
                  //         await _authRepository.updateEmail(
                  //           email: newDetail,
                  //         ),
                  //         context,
                  //         toastDuration: 5,
                  //       );
                  //       await _authRepository.signout();
                  //       await navigatorKey.currentState!.popAndPushNamed(
                  //         Routes.auth,
                  //       );
                  //     },
                  //     text: 'OK',
                  //     textStyle: Theme.of(context).textTheme.headline1,
                  //   ),
                  // )
                ],
              ),
            );
            break;
          case UserDetails.password:
            await _authRepository.updatePassword(
              passowrd: newDetail,
            );
            break;
          case UserDetails.mobileNumber:
            await _userRepo.setMobileNumber(
              _authRepository.getCurrentUser()!.uid,
              newDetail,
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
      final imageURL = await _storageRepository.uploadProfilePic(
        photoFile: File(image.path),
        email: _authRepository.getCurrentUser()!.email!,
      );
      await _authRepository.updateProfilePic(photoURL: imageURL);
      navigatorKey.currentState!.pop();
      await navigatorKey.currentState!.popAndPushNamed(
        Routes.auth,
      );
    }
  }

  Future<void> registerAccount(
    String email,
    String password,
  ) async {
    final restaurantTitle = await _restaurantRepo.fetchRestaurantTitle(
      _authRepository.getCurrentUser()!.uid,
    );
    await _authRepository.adminSignUp(
      email: email,
      password: password,
      restaurantTitle: restaurantTitle,
    );
    await _restaurantRepo.setRestaurantEmail(
      email,
      _authRepository.getCurrentUser()!.uid,
    );
    scaffoldKey.currentState!.showSnackBar(
      const SnackBar(content: Text('Restaurant account added sucessfully')),
    );
  }
}
