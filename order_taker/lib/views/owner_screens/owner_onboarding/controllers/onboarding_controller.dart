import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../enums/image_type.dart';
import '../../../../models/menu_item_model.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../providers/repository_providers.dart';
import '../../../resources/route_manager.dart';
import 'onboarding_providers.dart';

class OnboardingNotifier extends StateNotifier<void> {
  OnboardingNotifier({required StateNotifierProviderRef ref})
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
      builder: (_) => AlertDialog(
        title: Text(''),
        content: content,
      ),
    );
  }

  Future<void> addItemImage(
    ImageTypes imageTypes,
    String restaurantName,
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
                restaurantName: restaurantName,
                itemName: itemName,
              );
      _ref.read(itemImageProvider.notifier).update((state) => downloadUrl);
    }
  }

  Future<void> addMenuItem(
    OrderItem orderItem,
  ) async {
    await _ref.read(firestoreRepositoryProvider).addMenuItem(
          orderItem,
          await _ref.read(firestoreRepositoryProvider).fetchRestaurantTitle(
                _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
              ),
        );
  }

  Future<void> addRestaurantPictures() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    final List<String> downloadUrls = [];
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        final downloadUrl =
            await _ref.read(storageRepositoryProvider).uploadRestaurantImage(
                  photoFile: File(images[i].path),
                  index: i,
                  restaurantName: await _ref
                      .read(firestoreRepositoryProvider)
                      .fetchRestaurantTitle(
                        _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                      ),
                );
        downloadUrls.add(downloadUrl);
      }
      await _ref.read(firestoreRepositoryProvider).addRestaurantPhoto(
            downloadUrls,
            await _ref.read(firestoreRepositoryProvider).fetchRestaurantTitle(
                  _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
                ),
          );
    }
  }

  Future<void> submitRestaurantDetails() async {
    final String title =
        await _ref.read(firestoreRepositoryProvider).fetchRestaurantTitle(
              _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
            );
    await _ref.read(firestoreRepositoryProvider).submitRestaurantDetails(
          Restaurant(
            title: title,
            desc: _ref.read(restaurantDescriptionProvider),
            openHours: _ref.read(restaurantHoursProvider),
            website: _ref.read(restaurantWebsiteProvider),
            phoneNumber: _ref.read(restaurantPhoneNumberProvider),
            paymentMethods: _ref.read(restaurantPaymentProvider),
          ),
          _ref.read(restaurantInsideTablesProvider) as int,
          _ref.read(restaurantOutsideTablesProvider) as int,
        );
    await _ref.read(firestoreRepositoryProvider).setOnBoarding(
          _ref.read(authRepositoryProvider).getCurrentUser()!.uid,
          onBoarding: true,
        );
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}
