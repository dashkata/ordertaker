import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurant_state.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurant_widget.dart';

import '../../project_widgets.dart';

class RestaurantPage extends ConsumerStatefulWidget {
  const RestaurantPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends ConsumerState<RestaurantPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero,
        () => ref.read(restaurantNotifierProvider.notifier).fetchRestaurants());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(restaurantNotifierProvider, (prev, RestaurantState next) {
      if (next is RestaurantError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.message)));
      }
    });
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
              final state = ref.watch(restaurantNotifierProvider);
              if (state is RestaurantLoading) {
                return const CircularProgressIndicator();
              } else if (state is RestaurantLoaded) {
                return ListView.builder(
                  itemCount: state.restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                      restaurant: state.restaurants[index],
                    );
                  },
                );
              } else if (state is RestaurantError) {
                return const Text("error");
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}
