import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/menu_item_model.dart';
import '../providers/auth_provider.dart';
import '../providers/repository_providers.dart';
import '../themes/themes.dart';
import 'resources/padding_manager.dart';
import 'resources/route_manager.dart';
import 'resources/style_manager.dart';
import 'user_screens/menu_screen/controllers/menu_screen_providers.dart';
import 'user_screens/profile_screen/controllers/profile_screen_providers.dart';

class NormalButtons extends StatelessWidget {
  const NormalButtons({
    required this.buttonText,
    required this.buttonFunc,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? buttonFunc;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: buttonFunc,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.black,
          shape: const StadiumBorder(),
          backgroundColor: mainColor,
          elevation: 10,
        ),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.headline4,
        ),
      );
}

class ProfilePicture extends ConsumerWidget {
  const ProfilePicture({
    required this.radius,
    Key? key,
  }) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue picUrl = ref.watch(picProvider);
    return picUrl.when(
      data: (data) => CachedNetworkImage(
        imageUrl: data,
        imageBuilder: (context, url) => CircleAvatar(
          backgroundImage: url,
          radius: radius,
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, s) => Text('Error $e'),
    );
    // return const Text("Error when loading profile picture");
  }
}

class TextFields extends StatelessWidget {
  const TextFields({
    required this.hintText,
    required this.icon,
    required this.obscure,
    required this.inputType,
    required this.textInputAction,
    required this.func,
    Key? key,
  }) : super(key: key);

  final String? hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType inputType;
  final void Function(String)? func;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: DoubleTextField(
          func: func,
          inputType: inputType,
          icon: icon,
          hintText: hintText,
          obscure: obscure,
          textInputAction: textInputAction,
        ),
      );
}

class DoubleTextField extends StatelessWidget {
  const DoubleTextField({
    required this.func,
    required this.inputType,
    required this.icon,
    required this.hintText,
    required this.obscure,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  final TextInputType inputType;
  final IconData icon;
  final String? hintText;
  final bool obscure;
  final TextInputAction textInputAction;
  final void Function(String)? func;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: Material(
          borderRadius: Styles.buildBorderRadius(30),
          elevation: 10,
          child: TextField(
            onChanged: func,
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: accentColor,
              ),
              enabledBorder: Styles.buildOutlineBorder(
                accentColor,
                30,
              ),
              border: Styles.buildOutlineBorder(
                accentColor,
                30,
              ),
              focusedBorder: Styles.buildOutlineBorder(
                accentColor,
                30,
              ),
              prefixIconColor: accentColor,
              hintText: hintText,
              filled: true,
              fillColor: mainColor,
              hintStyle: Theme.of(context).textTheme.headline1,
            ),
            obscureText: obscure,
            autocorrect: false,
            textInputAction: textInputAction,
          ),
        ),
      );
}

class BackgroundWidgetAuthPages extends StatelessWidget {
  const BackgroundWidgetAuthPages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background2.png'),
            fit: BoxFit.fill,
          ),
        ),
      );
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.png'),
            fit: BoxFit.fill,
          ),
        ),
      );
}

class DrawerTab extends StatelessWidget {
  const DrawerTab({
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
        title: Text(titleText),
        onTap: func,
      );
}

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
                  const ProfilePicture(radius: 45),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.displayName!,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            if (userType == 'Customer')
              Column(
                children: [
                  DrawerTab(
                    icon: Icons.local_pizza,
                    titleText: text.restaurants,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, Routes.userRestaurants);
                    },
                  ),
                  DrawerTab(
                    icon: Icons.edit_note,
                    titleText: text.reservations,
                    func: () {
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, Routes.userReservations);
                    },
                  ),
                  DrawerTab(
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
                  DrawerTab(
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
                  DrawerTab(
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
            DrawerTab(
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
      loading: () => const LoadingIndicator(),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}

class UnfocusDetector extends StatelessWidget {
  const UnfocusDetector({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: child,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      );
}

class MenuCard extends ConsumerWidget {
  const MenuCard({
    required this.orderItem,
    Key? key,
  }) : super(key: key);
  final OrderItem orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: PaddingManager.p4,
        child: GestureDetector(
          onTap: () =>
              ref.read(menuCardsControllerProvider.notifier).addMenuCard(
                    orderItem,
                  ),
          child: Card(
            color: mainColor,
            elevation: 10,
            shape: Styles.buildRoundedBorder(40),
            child: Row(
              children: [
                Padding(
                  padding: PaddingManager.p5,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(orderItem.itemImage),
                    radius: 40,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItem.itemTitle,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          orderItem.itemPrice,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          orderItem.itemIngredients,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: Center(
          child: Text(
            'An error has occurred',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        children: [
          Center(
            child: Text(
              errorMessage,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
