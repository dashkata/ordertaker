import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/restaurant_details.dart';
import '../../../models/restaurant_model.dart';
import '../controllers/owner_restaurant_info_providers.dart';

class AddressButton extends ConsumerWidget {
  const AddressButton({
    required this.restaurant,
    required this.admin,
    Key? key,
  }) : super(key: key);
  final bool admin;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(locationControllerProvider(restaurant.address));
    return admin
        ? TextField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            controller: controller,
            onEditingComplete: () => ref
                .read(restaurantInfoControllerProvider.notifier)
                .submitRestaurantDetails(
                  ref,
                  RestaurantDetailsType.address,
                  controller.value.text,
                  restaurant.title,
                ),
            enabled: admin,
            textInputAction: TextInputAction.done,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              onPressed: () {
                ref
                    .read(restaurantInfoControllerProvider.notifier)
                    .launchMapWithAddress(
                      restaurant.address,
                    );
              },
              child: Text(
                restaurant.address,
                style: Theme.of(context).textTheme.headline1,
                // textAlign: TextAlign.left,
              ),
            ),
          );
  }
}
