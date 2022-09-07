import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/restaurant_screen_providers.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/widgets/restaurant_card.dart';

import '../../../models/restaurant_model.dart';
import '../../project_widgets.dart';

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
                    error: (e, s) => GFToast.showToast(
                      e.toString(),
                      context,
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
