import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/image_type.dart';
import '../../../enums/user_details.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/repository_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/profile_picture.dart';
import '../../resources/style_manager.dart';
import 'controllers/profile_screen_providers.dart';

part 'widgets/admin_restaurant_card.dart';
part 'widgets/dialog_parts.dart';
part 'widgets/profile_divider.dart';
part 'widgets/profile_list_tile.dart';
part 'widgets/profile_picture.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          text.profile,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContainerPicture(text: text),
                const SizedBox(
                  height: 5,
                ),
                Consumer(
                  builder: (_, ref, child) => _ProfileListTile(
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
                Consumer(
                  builder: (context, ref, child) {
                    final AsyncValue mobileNumber =
                        ref.watch(phoneNumberProvider);
                    return _ProfileListTile(
                      detail: mobileNumber.when(
                        data: (mobileNumber) => mobileNumber,
                        error: (e, s) => 'Mobile number not set',
                        loading: () => ' ',
                      ),
                      icon: Icons.phone,
                      hintText: text.change_mobile_number,
                      changeProvider: phoneChangeProvider,
                      detailType: UserDetails.mobileNumber,
                      obscure: false,
                    );
                  },
                ),
                const ProfileDivider(),
                const SizedBox(
                  height: 5,
                ),
                Consumer(
                  builder: (_, ref, child) => _ProfileListTile(
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
                _ProfileListTile(
                  detail: '*********',
                  icon: Icons.password,
                  hintText: text.enter_your_new_password,
                  changeProvider: passwordChangeProvider,
                  detailType: UserDetails.password,
                  obscure: true,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final userType = ref.watch(userTypeProvider);
                    return userType.when(
                      data: (type) => type == 'Admin'
                          ? const _AdminRestaurantCard()
                          : const SizedBox.shrink(),
                      error: (e, s) =>
                          ErrorAlertDialog(errorMessage: e.toString()),
                      loading: () => const CustomProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
