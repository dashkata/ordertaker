part of '../owner_restaurant_info.dart';

class _DetailsSection extends ConsumerWidget {
  const _DetailsSection({
    required this.restaurant,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;

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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Text(
                    restaurant.desc,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DescriptionIcon(
                      information: restaurant.openHours,
                      infoIcon: Icons.watch_later,
                    ),
                    _DescriptionIcon(
                      information: restaurant.phoneNumber,
                      infoIcon: Icons.phone,
                    ),
                    _DescriptionIcon(
                      information: restaurant.paymentMethods,
                      infoIcon: Icons.payment,
                    ),
                    _DescriptionIcon(
                      information: restaurant.website,
                      infoIcon: Icons.web_asset,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
