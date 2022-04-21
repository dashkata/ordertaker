import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/providers/restaurants_provider.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurant_widget.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class RestaurantPage extends ConsumerWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView.builder(
              itemCount: restaurants.value?.length,
              itemBuilder: (context, index) {
                return restaurants.when(data: (restaurant) {
                  return RestaurantCard(
                      resTitle: restaurant.elementAt(index).resTitle,
                      resDesc: restaurant.elementAt(index).resDesc,
                      imagePath: restaurant.elementAt(index).imagePath);
                }, error: (e, s) {
                  return Center(
                    child: Text("An error accured"),
                  );
                }, loading: () {
                  return CircularProgressIndicator();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
