import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/menu_section_model.dart';
import '../../../models/restaurant_info_model.dart';
import '../../../models/restaurant_model.dart';
import '../../../providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_menu_card.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../project_widgets.dart';
import '../../resources/style_manager.dart';
import '../owner_onboarding/controllers/onboarding_providers.dart';
import 'controllers/owner_restaurant_info_providers.dart';

class OwnerRestaurantInfo extends StatelessWidget {
  const OwnerRestaurantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        drawer: const CustomDrawer(),
        backgroundColor: mainColor,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final AsyncValue<Restaurant> asyncInfo =
                  ref.watch(restaurantInformationProvider);
              return ref.watch(restaurantTitleProvider).when(
                    data: (title) {
                      final AsyncValue<List<MenuSection>> asyncMenu =
                          ref.watch(menuProvider(title));
                      return asyncInfo.when(
                        data: (info) => ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info.title,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: accentBlackColor,
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                info.desc,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: accentBlackColor,
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Photos from the restaurant',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 3,
                              ),
                              itemCount: info.photos.length,
                              itemBuilder: (context, index) => DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: Styles.buildBorderRadius(30),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      info.photos[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: accentBlackColor,
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Menu',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                              color: accentBlackColor,
                              height: 50,
                            ),
                            asyncMenu.when(
                              data: (menu) => ListView.builder(
                                shrinkWrap: true,
                                itemCount: menu.length,
                                itemBuilder: (_, index) => Column(
                                  children: List.generate(
                                    menu[index].items.length,
                                    (indexSelection) => MenuCard(
                                      orderItem:
                                          menu[index].items[indexSelection],
                                    ),
                                  ),
                                ),
                              ),
                              error: (e, s) => Text(
                                e.toString(),
                              ),
                              loading: () => const CustomProgressIndicator(),
                            ),
                            if (info.reviews != null)
                              Column(
                                children: List.generate(
                                  info.reviews!.length,
                                  (index) => Text(
                                    info.reviews![index],
                                  ),
                                ),
                              )
                          ],
                        ),
                        error: (e, s) => Text(e.toString()),
                        loading: () => const CustomProgressIndicator(),
                      );
                    },
                    error: (e, s) => Text(e.toString()),
                    loading: () => const CustomProgressIndicator(),
                  );
            },
          ),
        ),
      );
}
