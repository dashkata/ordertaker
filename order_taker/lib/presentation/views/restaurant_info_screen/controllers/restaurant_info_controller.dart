import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:order_taker/domain/repositories/restaurant_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../enums/restaurant_details.dart';
import '../../resources/route_manager.dart';

class RestaurantInfoController extends StateNotifier<void> {
  RestaurantInfoController({
    required RestaurantRepo restaurantRepo,
  })  : _restaurantRepo = restaurantRepo,
        super(null);
  final RestaurantRepo _restaurantRepo;

  void submitRestaurantDetails(
    RestaurantDetailsType restaurantDetailsType,
    String updateInfo,
    String restaurantTitle,
  ) {
    _restaurantRepo.updateRestaurantInformation(
      updateInfo,
      restaurantTitle,
      restaurantDetailsType.name,
    );
  }

  Future<void> launchMapWithAddress(String address) async {
    final List<Location> locations = await locationFromAddress(address);
    final availableMaps = await MapLauncher.installedMaps;
    await showModalBottomSheet(
      context: navigatorKey.currentState!.context,
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            children: <Widget>[
              for (var map in availableMaps)
                ListTile(
                  onTap: () => map.showMarker(
                    coords:
                        Coords(locations[0].latitude, locations[0].longitude),
                    title: address,
                  ),
                  title: Text(map.mapName),
                  leading: SvgPicture.asset(
                    map.icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchWebsite(String website) async {
    if (website.contains('https://')) {
      await launchUrl(Uri.parse(website));
    } else {
      await launchUrl(
        Uri.parse(
          'https://$website',
        ),
      );
    }
  }

  Future<void> callPhoneNumber(String phoneNumber) async {
    await launchUrl(
      Uri(
        scheme: 'tel',
        path: phoneNumber,
      ),
    );
  }
}
