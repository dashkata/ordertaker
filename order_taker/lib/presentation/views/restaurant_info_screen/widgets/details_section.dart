part of '../restaurant_info.dart';

class _DetailsSection extends ConsumerWidget {
  const _DetailsSection({
    required this.restaurant,
    required this.admin,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;
  final bool admin;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Text(
                    restaurant.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final controller = ref.watch(
                      descriptionControllerProvider(
                        restaurant.description,
                      ),
                    );
                    return TextField(
                      controller: controller,
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
                      readOnly: !admin,
                      maxLines: null,
                      onEditingComplete: () => ref
                          .read(restaurantInfoControllerProvider.notifier)
                          .submitRestaurantDetails(
                            RestaurantDetailsType.address,
                            controller.value.text,
                            restaurant.title,
                          ),
                      enabled: admin,
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
                Row(
                  children: [
                    AddressButton(
                      restaurant: restaurant,
                      admin: admin,
                    ),
                  ],
                ),
                _DescriptionIcon(
                  information: restaurant.website,
                  infoIcon: Icons.web_asset,
                  controllerProvider: websiteControllerProvider,
                  restaurantTitle: restaurant.title,
                  restaurantDetailsType: RestaurantDetailsType.website,
                  admin: admin,
                  onTap: () => ref
                      .read(restaurantInfoControllerProvider.notifier)
                      .launchWebsite(
                        restaurant.website,
                      ),
                ),
                _DescriptionIcon(
                  information: restaurant.phoneNumber,
                  infoIcon: Icons.phone,
                  controllerProvider: phoneNumberControllerProvider,
                  restaurantTitle: restaurant.title,
                  restaurantDetailsType: RestaurantDetailsType.phoneNumber,
                  admin: admin,
                  onTap: () => ref
                      .read(restaurantInfoControllerProvider.notifier)
                      .callPhoneNumber(
                        restaurant.phoneNumber,
                      ),
                ),
                _DescriptionIcon(
                  information: restaurant.openHours,
                  infoIcon: Icons.watch_later,
                  controllerProvider: workingHoursControllerProvider,
                  restaurantTitle: restaurant.title,
                  restaurantDetailsType: RestaurantDetailsType.openHours,
                  admin: admin,
                ),
                _DescriptionIcon(
                  information: restaurant.paymentMethods,
                  infoIcon: Icons.payment,
                  controllerProvider: paymentMethodsControllerProvider,
                  restaurantTitle: restaurant.title,
                  restaurantDetailsType: RestaurantDetailsType.paymentMethods,
                  admin: admin,
                ),
              ],
            ),
          ),
        ),
      );
}
