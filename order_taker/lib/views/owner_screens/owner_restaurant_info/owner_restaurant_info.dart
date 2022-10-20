import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../../models/menu_section_model.dart';
import '../../../models/restaurant_info_model.dart';
import '../../../models/restaurant_model.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';
import '../owner_onboarding/controllers/onboarding_providers.dart';
import 'controllers/owner_restaurant_info_providers.dart';

class OwnerRestaurantInfo extends StatelessWidget {
  const OwnerRestaurantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Consumer(
          builder: (child, ref, context) => FloatingActionButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signout();
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: appBarColor,
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
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
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        info.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: accentColor,
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    info.desc,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: accentColor,
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Photos from the restaurant',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ),
                                  ],
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemCount: 3,
                                  itemBuilder: (context, index) =>
                                      Text("hello"),
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: accentColor,
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Menu',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: accentColor,
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
                                  loading: () => const LoadingIndicator(),
                                ),
                              ],
                            ),
                            error: (e, s) => Text(e.toString()),
                            loading: () => const LoadingIndicator(),
                          );
                        },
                        error: (e, s) => Text(e.toString()),
                        loading: () => const LoadingIndicator(),
                      );
                },
              ),
            ),
          ],
        ),
      );
}
