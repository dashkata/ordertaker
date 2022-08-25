import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/resources/padding_manager.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import 'package:order_taker/views/resources/style_manager.dart';
import '../../../../models/restaurant_model.dart';
import 'find_a_table.dart';

class RestaurantCard extends ConsumerWidget {
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: PaddingManager.p1,
      child: InkWell(
        onTap: () => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .navigateToRestaurantInfo(restaurant.title),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: Styles.buildRoundedBorder(30),
          elevation: 10,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  //TODO update this
                  Consumer(builder: (context, ref, child) {
                    AsyncValue restaurantPic = ref.watch(
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
                                    BlendMode.dstATop),
                                image: url,
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                            ),
                        error: (e, s) =>
                            GFToast.showToast(e.toString(), context),
                        loading: () => const LoadingIndicator());
                    // return Container();
                  }),
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
                        FindATableButton(
                          resTitle: restaurant.title,
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
    );
  }
}
