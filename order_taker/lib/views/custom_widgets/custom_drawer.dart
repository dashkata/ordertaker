import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/repository_providers.dart';
import '../../themes/themes.dart';
import '../resources/route_manager.dart';
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
    final AsyncValue<String> asyncUserType = ref.watch(userTypeProvider);
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
                  const CustomProfilePicture(radius: 45),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   user.displayName!,
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
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
                          context, Routes.userReservations);
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
                    titleText: 'Restaurant information',
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
                    titleText: 'Restaurant accounts',
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.ownerEditAccounts,
                      );
                    },
                  ),
                ],
              ),
            if (userType == 'Restaurant')
              Column(
                children: [
                  _DrawerTab(
                    icon: Icons.info,
                    titleText: 'Tables',
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                        context,
                        Routes.restaurantTables,
                      );
                    },
                  ),
                  _DrawerTab(
                    icon: Icons.person,
                    titleText: 'Menu',
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
              func: () =>
                  auth.signout().then((value) => Navigator.pop(context)).then(
                        (value) =>
                            Navigator.popAndPushNamed(context, Routes.login),
                      ),
            ),
          ],
        ),
      ),
      error: (e, s) => Text(e.toString()),
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
