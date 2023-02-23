import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:readmore/readmore.dart';

import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/restaurant_screen_providers.dart';

part 'widgets/detail_dialog_parts.dart';
part 'widgets/find_a_table_button.dart';
part 'widgets/number_of_people.dart';
part 'widgets/radio_tile.dart';
part 'widgets/restaurant_card.dart';
part 'widgets/select_date.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.restaurants,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final AsyncValue<List<Restaurant>> restaurants =
                ref.watch(restaurantListProvider);
            return restaurants.when(
              data: (data) => SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => _RestaurantCard(
                      restaurant: data[index],
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
        ),
      ),
    );
  }
}
