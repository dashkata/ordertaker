part of '../restaurants.dart';

class _RestaurantCard extends ConsumerWidget {
  const _RestaurantCard({
    required this.restaurant,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: PaddingManager.p1,
        child: InkWell(
          onTap: () => ref
              .read(restaurantControllerProvider.notifier)
              .navigateToRestaurantInfo(restaurant: restaurant),
          child: SizedBox(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: Styles.buildRoundedBorder(30),
              elevation: 10,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: restaurant.photo,
                        imageBuilder: (context, url) => Ink.image(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8),
                            BlendMode.dstATop,
                          ),
                          image: url,
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      restaurant.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReadMoreText(
                          restaurant.desc,
                          style: Theme.of(context).textTheme.headline6,
                          trimLength: 100,
                          moreStyle: Theme.of(context).textTheme.headline1,
                          lessStyle: Theme.of(context).textTheme.headline1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _FindATableButton(
                              restaurant: restaurant,
                            ),
                          ],
                        ),
                      ],
                    ),
                    tileColor: complementaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
