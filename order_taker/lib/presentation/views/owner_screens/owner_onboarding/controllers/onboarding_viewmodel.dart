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
import 'package:order_taker/presentation/providers/auth_provider.dart';

import '../../../../../domain/models/restaurant_model.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import 'onboarding_providers.dart';

class OnBoardingViewModel extends StateNotifier<void> {
  OnBoardingViewModel({
    required StorageRepository storageRepository,
    required RestaurantRepo restaurantRepo,
    required AuthRepository authRepository,
    required UserRepo userRepo,
    required MenuRepo menuRepo,
  })  : _storageRepository = storageRepository,
        _restaurantRepo = restaurantRepo,
        _authRepository = authRepository,
        _userRepo = userRepo,
        _menuRepo = menuRepo,
        super(null);
  final StorageRepository _storageRepository;
  final RestaurantRepo _restaurantRepo;
  final AuthRepository _authRepository;
  final UserRepo _userRepo;
  final MenuRepo _menuRepo;
  final _dropDownItems = ['лв', '€'];

  List<String> get dropDownItems => _dropDownItems;

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
    WidgetRef ref,
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
      ref.read(itemImageProvider.notifier).update((state) => downloadUrl);
      scaffoldKey.currentState!.showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
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

  Future<void> addRestaurantPicture(WidgetRef ref) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final downloadUrl = await _storageRepository.uploadRestaurantImage(
        photoFile: File(image.path),
        restaurantName: await _restaurantRepo.fetchRestaurantTitle(
          _authRepository.getCurrentUser()!.uid,
        ),
      );
      ref.read(restaurantPhotoProvider.notifier).update(
            (state) => downloadUrl,
          );
      scaffoldKey.currentState!.showSnackBar(
        const SnackBar(content: Text('Image uploaded succesfully')),
      );
    }
  }

  Future<void> submitRestaurantDetails(WidgetRef ref) async {
    final String title = await _restaurantRepo.fetchRestaurantTitle(
      _authRepository.getCurrentUser()!.uid,
    );
    await _restaurantRepo.submitRestaurantDetails(
      Restaurant(
        title: title,
        description: ref.read(restaurantDescriptionProvider),
        openHours: ref.read(restaurantHoursProvider),
        website: ref.read(restaurantWebsiteProvider),
        phoneNumber: ref.read(restaurantPhoneNumberProvider),
        paymentMethods: ref.read(restaurantPaymentProvider),
        address: ref.read(restaurantAddressProvider),
        photo: ref.read(restaurantPhotoProvider),
      ),
      int.parse(ref.read(restaurantTablesProvider)),
    );
    await _userRepo.setOnBoarding(
      _authRepository.getCurrentUser()!.uid,
      onBoarding: true,
    );
    ref.invalidate(futureOnBoardingProvider);
    await navigatorKey.currentState!.popAndPushNamed(Routes.auth);
  }
}
