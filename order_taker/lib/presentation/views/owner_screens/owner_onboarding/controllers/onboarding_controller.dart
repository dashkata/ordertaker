import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_taker/data/repositories/auth_repository.dart';
import 'package:order_taker/data/repositories/storage_repository.dart';
import 'package:order_taker/domain/models/menu_item_model.dart';
import 'package:order_taker/domain/repositories/menu_repo.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:order_taker/domain/repositories/user_repo.dart';
import 'package:order_taker/enums/image_type.dart';

import '../../../../../domain/models/restaurant_model.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import 'onboarding_providers.dart';

class OnboardingController extends StateNotifier<void> {
  OnboardingController({
    required StateNotifierProviderRef ref,
    required StorageRepository storageRepository,
    required RestaurantRepo restaurantRepo,
    required AuthRepository authRepository,
    required UserRepo userRepo,
    required MenuRepo menuRepo,
  })  : _ref = ref,
        _storageRepository = storageRepository,
        _restaurantRepo = restaurantRepo,
        _authRepository = authRepository,
        _userRepo = userRepo,
        _menuRepo = menuRepo,
        super(null);
  final StateNotifierProviderRef _ref;
  final StorageRepository _storageRepository;
  final RestaurantRepo _restaurantRepo;
  final AuthRepository _authRepository;
  final UserRepo _userRepo;
  final MenuRepo _menuRepo;

  void addMenuDialog(Widget alertDialog, BuildContext context) {
    showDialog(context: context, builder: (_) => alertDialog);
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
      final downloadUrl = await _storageRepository.uploadItemImage(
        photoFile: File(image!.path),
        restaurantName: await _restaurantRepo.fetchRestaurantTitle(
          _authRepository.getCurrentUser()!.uid,
        ),
        itemName: itemName,
      );
      _ref.read(itemImageProvider.notifier).update((state) => downloadUrl);
    }
  }

  Future<void> addMenuItem(
    OrderItem orderItem,
  ) async {
    await _menuRepo.addMenuItem(
      orderItem,
      await _restaurantRepo.fetchRestaurantTitle(
        _authRepository.getCurrentUser()!.uid,
      ),
    );
  }

  Future<void> addRestaurantPicture() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final downloadUrl = await _storageRepository.uploadRestaurantImage(
        photoFile: File(image.path),
        restaurantName: await _restaurantRepo.fetchRestaurantTitle(
          _authRepository.getCurrentUser()!.uid,
        ),
      );
      _ref.read(restaurantPhotoProvider.notifier).update(
            (state) => downloadUrl,
          );
    }
  }

  //TODO update this maybe
  Future<void> submitRestaurantDetails() async {
    final String title = await _restaurantRepo.fetchRestaurantTitle(
      _authRepository.getCurrentUser()!.uid,
    );
    await _restaurantRepo.submitRestaurantDetails(
      Restaurant(
        title: title,
        description: _ref.read(restaurantDescriptionProvider),
        openHours: _ref.read(restaurantHoursProvider),
        website: _ref.read(restaurantWebsiteProvider),
        phoneNumber: _ref.read(restaurantPhoneNumberProvider),
        paymentMethods: _ref.read(restaurantPaymentProvider),
        address: _ref.read(restaurantAddressProvider),
        photo: _ref.read(restaurantPhotoProvider),
      ),
      int.parse(_ref.read(restaurantTablesProvider)),
    );
    await _userRepo.setOnBoarding(
      _authRepository.getCurrentUser()!.uid,
      onBoarding: true,
    );
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}
