import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import 'onboarding_providers.dart';

class OnboardingController extends StateNotifier<void> {
  OnboardingController({required StateNotifierProviderRef ref})
      : _ref = ref,
        super(null);
  final StateNotifierProviderRef _ref;

  void addMenuDialog(Widget alertDialog, BuildContext context) {
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void updateTextField(StateProvider provider, String value) {
    _ref.read(provider.notifier).update((state) => value);
  }

  Future<void> pickItemImage(BuildContext context, Widget content) async {
    await showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(
        content: content,
      ),
    );
  }

  Future<void> addItemImage(
    ImageTypes imageTypes,
    String itemName,
  ) async {
    XFile? image;
    switch (imageTypes) {
      case ImageTypes.camera:
        image = await ImagePicker().pickImage(source: ImageSource.camera);
        break;
      case ImageTypes.gallery:
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
        break;
    }
    if (image?.path != null) {
      final downloadUrl =
          await _ref.read(storageRepositoryProvider).uploadItemImage(
                photoFile: File(image!.path),
                restaurantName: await _ref
                    .read(firestoreAPIProvider)
                    .fetchRestaurantTitle(
                      _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                    ),
                itemName: itemName,
              );
      _ref.read(itemImageProvider.notifier).update((state) => downloadUrl);
    }
  }

  Future<void> addMenuItem(
    OrderItem orderItem,
  ) async {
    await _ref.read(firestoreAPIProvider).addMenuItem(
          orderItem,
          await _ref.read(firestoreAPIProvider).fetchRestaurantTitle(
                _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
              ),
        );
  }

  Future<void> addRestaurantPicture() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final downloadUrl =
          await _ref.read(storageRepositoryProvider).uploadRestaurantImage(
                photoFile: File(image.path),
                restaurantName: await _ref
                    .read(firestoreAPIProvider)
                    .fetchRestaurantTitle(
                      _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                    ),
              );
      _ref.read(restaurantPhotoProvider.notifier).update(
            (state) => downloadUrl,
          );
    }
  }

  Future<void> submitRestaurantDetails() async {
    final String title =
        await _ref.read(firestoreAPIProvider).fetchRestaurantTitle(
              _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
            );
    // await _ref.read(firestoreAPIProvider).submitRestaurantDetails(
    //       Restaurant(
    //         title: title,
    //         desc: _ref.read(restaurantDescriptionProvider),
    //         openHours: _ref.read(restaurantHoursProvider),
    //         website: _ref.read(restaurantWebsiteProvider),
    //         phoneNumber: _ref.read(restaurantPhoneNumberProvider),
    //         paymentMethods: _ref.read(restaurantPaymentProvider),
    //         address: _ref.read(restaurantAddressProvider),
    //         photo: _ref.read(restaurantPhotoProvider),
    //       ),
    //       int.parse(_ref.read(restaurantTablesProvider)),
    //     );
    await _ref.read(firestoreAPIProvider).setOnBoarding(
          _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          onBoarding: true,
        );
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}
