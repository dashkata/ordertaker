import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/restaurants_provider.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/screens/user_screens/restaurant_page/restaurant_widget.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Consumer(builder: (context, ref, child) {
              final restaurants = ref.watch(restaurantProvider);
              return ListView.builder(
                itemCount: restaurants.value?.length,
                itemBuilder: (context, index) {
                  return restaurants.when(
                    data: (restaurant) {
                      return RestaurantCard(
                        resTitle: restaurant.elementAt(index).title,
                        resDesc: restaurant.elementAt(index).desc,
                        openHours: restaurant.elementAt(index).openHours,
                      );
                    },
                    error: (e, s) {
                      return const Center(
                        child: Text("An error occurred"),
                      );
                    },
                    loading: () {
                      return const CircularProgressIndicator();
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
