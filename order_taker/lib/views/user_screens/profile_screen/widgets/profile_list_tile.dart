import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/profile_provider.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/user_details.dart';
import 'package:order_taker/views/resources/route_manager.dart';

class ProfileListTile extends ConsumerWidget {
  const ProfileListTile({
    required this.detail,
    required this.icon,
    required this.hintText,
    required this.changeProvider,
    required this.obscure,
    required this.detailType,
    Key? key,
  }) : super(key: key);
  final String detail;
  final IconData icon;
  final String hintText;
  final StateProvider<bool> changeProvider;
  final UserDetails detailType;
  final bool obscure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return ListTile(
      leading: Icon(icon),
      title: AnimatedCrossFade(
        firstChild: Text(
          detail,
          style: Theme.of(context).textTheme.headline4,
        ),
        secondChild: TextField(
          onChanged: (value) => ref
              .read(changeControllerProvider.notifier)
              .update((state) => value),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.headline1,
          ),
          obscureText: obscure,
          autocorrect: false,
        ),
        crossFadeState: ref.watch(changeProvider)
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
      ),
      trailing: GFIconButton(
        icon: const Icon(Icons.edit),
        size: GFSize.SMALL,
        type: GFButtonType.transparent,
        shape: GFIconButtonShape.pills,
        color: Colors.white,
        onPressed: () =>
            ref.read(userProfileProvider.notifier).updateUserDetails(
                  ref,
                  detail,
                  context,
                  text,
                  detailType,
                  changeProvider,
                ),
      ),
    );
  }
}
