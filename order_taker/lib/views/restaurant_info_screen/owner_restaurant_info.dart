import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../../../enums/restaurant_details.dart';
import '../../../models/restaurant_model.dart';
import '../../../models/review_model.dart';
import '../../../providers/common_providers.dart';
import '../../../themes/themes.dart';

import '../custom_widgets/add_menu_button.dart';
import '../custom_widgets/custom_drawer.dart';
import '../custom_widgets/custom_error_alert_dialog.dart';
import '../custom_widgets/custom_menu_card.dart';
import '../custom_widgets/custom_progress_indicator.dart';
import '../custom_widgets/custom_remove_focus.dart';
import '../resources/padding_manager.dart';
import '../resources/style_manager.dart';
import 'controllers/owner_restaurant_info_providers.dart';

part 'widgets/description_icon.dart';

part 'widgets/details_section.dart';

part 'widgets/menu_section.dart';

part 'widgets/review_card.dart';

part 'widgets/reviews_section.dart';

part 'widgets/section_button.dart';

class OwnerRestaurantInfo extends StatelessWidget {
  const OwnerRestaurantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final Restaurant? restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant?;
    return RemoveFocusDetector(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
            floatingActionButton: Builder(
              builder: (context) => restaurant != null
                  ? IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: complementaryColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.menu,
                        color: complementaryColor,
                      ),
                    ),
            ),
            drawer: const CustomDrawer(),
            backgroundColor: mainColor,
            body: Stack(
              children: [
                if (restaurant != null)
                  Image(
                    height: MediaQuery.of(context).size.height / 3,
                    image: NetworkImage(restaurant!.photo),
                    fit: BoxFit.cover,
                  )
                else
                  Consumer(
                    builder: (context, ref, child) =>
                        ref.watch(restaurantInformationProvider).when(
                              data: (restaurantInfo) => Image(
                                height: MediaQuery.of(context).size.height / 3,
                                image: NetworkImage(restaurantInfo.photo),
                                fit: BoxFit.cover,
                              ),
                              error: (e, s) => ErrorAlertDialog(
                                errorMessage: e.toString(),
                              ),
                              loading: () => const CustomProgressIndicator(),
                            ),
                  ),
                Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(
                    top: 200,
                    bottom: 100,
                    left: 40,
                    right: 40,
                  ),
                  decoration: BoxDecoration(
                    color: complementaryColor,
                    borderRadius: Styles.buildBorderRadius(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final sectionId = ref.watch(sectionIdProvider);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (restaurant != null) ...[
                            if (sectionId == 0)
                              _DetailsSection(
                                restaurant: restaurant,
                                admin: false,
                              ),
                            if (sectionId == 1)
                              _MenuSection(
                                restaurant: restaurant,
                                admin: false,
                              ),
                            if (sectionId == 2)
                              _ReviewsSection(
                                restaurant: restaurant,
                              ),
                          ] else
                            ref.watch(restaurantInformationProvider).when(
                                  data: (restaurantInfo) => Expanded(
                                    child: Column(
                                      children: [
                                        if (sectionId == 0)
                                          _DetailsSection(
                                            restaurant: restaurantInfo,
                                            admin: true,
                                          ),
                                        if (sectionId == 1)
                                          _MenuSection(
                                            restaurant: restaurantInfo,
                                            admin: true,
                                          ),
                                        if (sectionId == 2)
                                          _ReviewsSection(
                                            restaurant: restaurantInfo,
                                          ),
                                      ],
                                    ),
                                  ),
                                  error: (e, s) => ErrorAlertDialog(
                                    errorMessage: e.toString(),
                                  ),
                                  loading: () =>
                                      const CustomProgressIndicator(),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _SectionButton(
                                  sectionText: text.details,
                                  id: 0,
                                ),
                                _SectionButton(
                                  sectionText: text.menu,
                                  id: 1,
                                ),
                                _SectionButton(
                                  sectionText: text.reviews,
                                  id: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
