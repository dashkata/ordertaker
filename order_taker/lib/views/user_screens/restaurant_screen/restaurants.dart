import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Themes/themes.dart';
import '../../../models/restaurant_model.dart';
import '../../../providers/controller_providers.dart';
import '../../../providers/repository_providers.dart';
import '../../../providers/restaurant_screen_providers.dart';
import '../../project_widgets.dart';
import 'widgets/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  final AsyncValue<List<Restaurant>> restaurants =
                      ref.watch(fetchRestaurantsProvider);
                  return restaurants.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          RestaurantCard(
                        restaurant: data[index],
                      ),
                    ),
                    error: (e, s) => Text(
                      e.toString(),
                    ),
                    loading: () => const LoadingIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
