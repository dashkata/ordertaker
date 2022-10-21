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
              .read(restaurantDialogNotifierProvider.notifier)
              .navigateToRestaurantInfo(restaurant.title),
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
                      Consumer(
                        builder: (context, ref, child) {
                          final AsyncValue restaurantPic = ref.watch(
                            restaurantPictureProvider(
                              restaurant.title,
                            ),
                          );
                          return restaurantPic.when(
                            data: (imageUrl) => CachedNetworkImage(
                              imageUrl: restaurantPic.value,
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
                            error: (e, s) => Text(
                              e.toString(),
                            ),
                            loading: () => const CustomProgressIndicator(),
                          );
                          // return Container();
                        },
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
                        Text(
                          restaurant.desc,
                          style: Theme.of(context).textTheme.headline6,
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
