import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/domain/models/review_model.dart';
import 'package:order_taker/presentation/providers/common_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:readmore/readmore.dart';

import '../../../enums/restaurant_details.dart';
import '../custom_widgets/add_menu_button.dart';
import '../custom_widgets/custom_drawer.dart';
import '../custom_widgets/custom_error_alert_dialog.dart';
import '../custom_widgets/custom_menu_card.dart';
import '../custom_widgets/custom_progress_indicator.dart';
import '../custom_widgets/custom_remove_focus.dart';
import '../resources/padding_manager.dart';
import '../resources/style_manager.dart';
import 'controllers/owner_restaurant_info_providers.dart';
import 'widgets/location_button.dart';

part 'widgets/description_icon.dart';
part 'widgets/details_section.dart';
part 'widgets/menu_section.dart';
part 'widgets/review_card.dart';
part 'widgets/reviews_section.dart';
part 'widgets/section_button.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({Key? key}) : super(key: key);

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
            resizeToAvoidBottomInset: false,
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
                    width: MediaQuery.of(context).size.width,
                    image: NetworkImage(restaurant.photo),
                    fit: BoxFit.cover,
                  )
                else
                  Consumer(
                    builder: (context, ref, child) =>
                        ref.watch(restaurantInformationViewModel).when(
                              data: (restaurantInfo) => Image(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
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
                            ref.watch(restaurantInformationViewModel).when(
                                  data: (restaurantInfo) {
                                    if (sectionId == 0) {
                                      return _DetailsSection(
                                        restaurant: restaurantInfo,
                                        admin: true,
                                      );
                                    } else if (sectionId == 1) {
                                      return _MenuSection(
                                        restaurant: restaurantInfo,
                                        admin: true,
                                      );
                                    } else if (sectionId == 2) {
                                      return _ReviewsSection(
                                        restaurant: restaurantInfo,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
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
