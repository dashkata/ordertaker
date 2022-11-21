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
  Widget build(BuildContext context, WidgetRef ref) => Scrollbar(
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final controller = ref.watch(
                  descriptionControllerProvider(
                    restaurant.desc,
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
                        ref,
                        RestaurantDetailsType.description,
                        controller.value.text,
                        restaurant.title,
                      ),
                  enabled: admin,
                  textInputAction: TextInputAction.done,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DescriptionIcon(
                information: restaurant.openHours,
                infoIcon: Icons.watch_later,
                controllerProvider: workingHoursControllerProvider,
                restaurantTitle: restaurant.title,
                restaurantDetailsType: RestaurantDetailsType.openHours,
                admin: admin,
              ),
              _DescriptionIcon(
                information: restaurant.phoneNumber,
                infoIcon: Icons.phone,
                controllerProvider: phoneNumberControllerProvider,
                restaurantTitle: restaurant.title,
                restaurantDetailsType: RestaurantDetailsType.phoneNumber,
                admin: admin,
              ),
              _DescriptionIcon(
                information: restaurant.paymentMethods,
                infoIcon: Icons.payment,
                controllerProvider: paymentMethodsControllerProvider,
                restaurantTitle: restaurant.title,
                restaurantDetailsType:
                    RestaurantDetailsType.paymentMethods,
                admin: admin,
              ),
              _DescriptionIcon(
                information: restaurant.website,
                infoIcon: Icons.web_asset,
                controllerProvider: websiteControllerProvider,
                restaurantTitle: restaurant.title,
                restaurantDetailsType: RestaurantDetailsType.website,
                admin: admin,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}