import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/menu_section_model.dart';
import '../../../models/restaurant_model.dart';
import '../../../providers/common_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/add_menu_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_menu_card.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../project_widgets.dart';
import '../../resources/style_manager.dart';
import 'controllers/owner_restaurant_info_providers.dart';

part 'widgets/description_icon.dart';

part 'widgets/section_button.dart';

part 'widgets/details_section.dart';

part 'widgets/menu_section.dart';

part 'widgets/reviews_section.dart';

class OwnerRestaurantInfo extends StatelessWidget {
  const OwnerRestaurantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Restaurant? restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant?;
    return Stack(
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
              Image(
                height: MediaQuery.of(context).size.height / 3,
                image: const AssetImage(
                  'assets/PizzaDonVito.jpg',
                ),
                fit: BoxFit.cover,
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
                            ),
                          if (sectionId == 1)
                            _MenuSection(
                              restaurant: restaurant,
                              admin: false,
                            ),
                          if (sectionId == 2) const _ReviewsSection(),
                        ] else
                          ref.watch(restaurantInformationProvider).when(
                                data: (restaurantInfo) => Expanded(
                                  child: Column(
                                    children: [
                                      if (sectionId == 0)
                                        _DetailsSection(
                                          restaurant: restaurantInfo,
                                        ),
                                      if (sectionId == 1)
                                        _MenuSection(
                                          restaurant: restaurantInfo,
                                          admin: true,
                                        ),
                                      if (sectionId == 2)
                                        const _ReviewsSection(),
                                    ],
                                  ),
                                ),
                                error: (e, s) => ErrorAlertDialog(
                                  errorMessage: e.toString(),
                                ),
                                loading: () => const CustomProgressIndicator(),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              _SectionButton(
                                sectionText: 'Details',
                                id: 0,
                              ),
                              _SectionButton(
                                sectionText: 'Menu',
                                id: 1,
                              ),
                              _SectionButton(
                                sectionText: 'Reviews',
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
    );
  }
}
