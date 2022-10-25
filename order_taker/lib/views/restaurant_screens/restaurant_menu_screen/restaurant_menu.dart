import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Themes/themes.dart';
import '../../../providers/common_providers.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_menu_card.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../owner_screens/owner_onboarding/controllers/onboarding_providers.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.menu,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final asyncTitle = ref.watch(restaurantTitleProvider);
            return asyncTitle.when(
              data: (title) {
                final asyncMenu = ref.watch(menuProvider(title));
                return asyncMenu.when(
                  data: (menu) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: menu.length,
                    itemBuilder: (_, index) => Column(
                      children: List.generate(
                        menu[index].items.length,
                        (indexSelection) => MenuCard(
                          orderItem: menu[index].items[indexSelection],
                        ),
                      ),
                    ),
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
}
