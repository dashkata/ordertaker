import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:order_taker/user_details.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';
import 'widgets/profile_divider.dart';
import 'widgets/profile_list_tile.dart';
import 'widgets/profile_picture.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    AsyncValue _mobileNumber = ref.watch(phoneNumberProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContainerPicture(text: text),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer(
                    builder: (_, ref, child) => ProfileListTile(
                      detail: ref
                          .watch(authRepositoryProvider)
                          .getCurrentUser()!
                          .displayName!,
                      icon: Icons.person,
                      hintText: text.change_name,
                      changeProvider: nameChangeProvider,
                      detailType: UserDetails.name,
                      obscure: false,
                    ),
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: _mobileNumber.when(
                        data: (mobileNumber) => mobileNumber,
                        error: (e, s) => "Mobile number not set",
                        loading: () => " "),
                    icon: Icons.phone,
                    hintText: text.change_mobile_number,
                    changeProvider: phoneChangeProvider,
                    detailType: UserDetails.mobileNumber,
                    obscure: false,
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer(
                    builder: (_, ref, child) => ProfileListTile(
                      detail: ref
                          .watch(authRepositoryProvider)
                          .getCurrentUser()!
                          .email!,
                      icon: Icons.mail,
                      hintText: text.change_email_address,
                      detailType: UserDetails.email,
                      changeProvider: emailChangeProvider,
                      obscure: false,
                    ),
                  ),
                  const ProfileDivider(),
                  const SizedBox(
                    height: 5,
                  ),
                  ProfileListTile(
                    detail: "*********",
                    icon: Icons.password,
                    hintText: text.enter_your_new_password,
                    changeProvider: passwordChangeProvider,
                    detailType: UserDetails.password,
                    obscure: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

