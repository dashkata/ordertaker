import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/common_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_menu_card.dart';
import '../../custom_widgets/custom_progress_indicator.dart';

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
                  data: (menu) => SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        menu.length,
                        (index) => Column(
                          children: List.generate(
                            menu[index].items.length,
                            (indexSelection) => MenuCard(
                              orderItem: menu[index].items[indexSelection],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  error: (e, s) => ErrorAlertDialog(
                    errorMessage: e.toString(),
                  ),
                  loading: () => const CustomProgressIndicator(),
                );
              },
              error: (e, s) => ErrorAlertDialog(
                errorMessage: e.toString(),
              ),
              loading: () => const CustomProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
