import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/auth_provider.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../resources/route_manager.dart';
import 'custom_error_alert_dialog.dart';
import 'custom_progress_indicator.dart';
import 'profile_picture.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final auth = ref.watch(authRepositoryProvider);
    final User user = auth.getCurrentUser()!;
    final AsyncValue<String> asyncUserType = ref.watch(futureUserTypeProvider);
    return asyncUserType.when(
      data: (userType) => Drawer(
        backgroundColor: mainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: complementaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (userType != 'Restaurant')
                    const CustomProfilePicture(radius: 45),
                  const SizedBox(
                    height: 10,
                  ),
                  if (userType != 'Restaurant')
                    Text(
                      user.displayName!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                ],
              ),
            ),
            if (userType == 'Customer')
              Column(
                children: [
                  _DrawerTab(
                    icon: Icons.local_pizza,
                    titleText: text.restaurants,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.userRestaurants,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.edit_note,
                    titleText: text.reservations,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.userReservations,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.person,
                    titleText: text.profile,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, Routes.profile);
                    },
                  ),
                ],
              ),
            if (userType == 'Admin')
              Column(
                children: [
                  _DrawerTab(
                    icon: Icons.info,
                    titleText: text.restaurant_info,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.ownerRestaurantInfo,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.person,
                    titleText: text.profile,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, Routes.profile);
                    },
                  ),
                ],
              ),
            if (userType == 'Restaurant')
              Column(
                children: [
                  _DrawerTab(
                    icon: Icons.info,
                    titleText: text.tables,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.restaurantTables,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.request_page,
                    titleText: text.request,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.restaurantRequests,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.person,
                    titleText: text.menu,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.restaurantMenu,
                      );
                    },
                  ),
                ],
              ),
            _DrawerTab(
              icon: Icons.exit_to_app,
              titleText: text.log_out,
              func: () => auth.signOut().then(
                    (value) =>
                        Navigator.pushReplacementNamed(context, Routes.auth),
                  ),
            ),
          ],
        ),
      ),
      error: (e, s) => ErrorAlertDialog(
        errorMessage: e.toString(),
      ),
      loading: () => const CustomProgressIndicator(),
    );
  }
}

class _DrawerTab extends StatelessWidget {
  const _DrawerTab({
    required this.icon,
    required this.titleText,
    required this.func,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String titleText;
  final void Function() func;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(
          icon,
        ),
        title: Text(
          titleText,
          style: Theme.of(context).textTheme.headline6,
        ),
        onTap: func,
      );
}
