import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/enums/restaurant_details.dart';

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
                  restaurantDetailsType: RestaurantDetailsType.address,
                  updateInfo: controller.value.text,
                  restaurantTitle: restaurant.title,
                ),
            enabled: admin,
            textInputAction: TextInputAction.done,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextButton(
              onPressed: () {
                ref
                    .read(restaurantInfoControllerProvider.notifier)
                    .launchMapWithAddress(
                      address: restaurant.address,
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
