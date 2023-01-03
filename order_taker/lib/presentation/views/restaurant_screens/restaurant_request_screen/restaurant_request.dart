import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/enums/request_status.dart';
import 'package:order_taker/presentation/providers/common_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:order_taker/presentation/views/resources/route_manager.dart';
import 'package:order_taker/presentation/views/restaurant_screens/restaurant_tables_screen/controllers/restaurant_tables_providers.dart';

import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_button_outlined.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../resources/style_manager.dart';
import 'controllers/restaurant_requests_providers.dart';

part 'widgets/request_card.dart';
part 'widgets/table_dialog.dart';

class RestaurantRequests extends StatelessWidget {
  const RestaurantRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text(
          text.request,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) => ref
              .watch(restaurantTitleProvider)
              .when(
                data: (title) {
                  final asyncRequests =
                      ref.watch(restaurantRequestsProvider(title));
                  return asyncRequests.when(
                    data: (requests) => SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          requests.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: _RequestCard(
                              reservation: requests[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    error: (e, s) => ErrorAlertDialog(
                      errorMessage: e.toString(),
                    ),
                    loading: () => const CustomProgressIndicator(),
                  );
                },
                error: (e, s) => ErrorAlertDialog(errorMessage: e.toString()),
                loading: () => const CustomProgressIndicator(),
              ),
        ),
      ),
    );
  }
}
