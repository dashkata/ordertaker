import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../../models/restaurant_model.dart';
import '../../../providers/common_providers.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../project_widgets.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'controllers/restaurant_screen_providers.dart';

part 'widgets/find_a_table_button.dart';

part 'widgets/restaurant_card.dart';

part 'widgets/select_date.dart';

part 'widgets/number_of_people.dart';

part 'widgets/free_tables.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Restaurants',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        drawer: const CustomDrawer(),
        backgroundColor: mainColor,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final AsyncValue<List<Restaurant>> restaurants =
                  ref.watch(fetchRestaurantsProvider);
              return restaurants.when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _RestaurantCard(
                    restaurant: data[index],
                  ),
                ),
                error: (e, s) => Text(
                  e.toString(),
                ),
                loading: () => const CustomProgressIndicator(),
              );
            },
          ),
        ),
      );
}
