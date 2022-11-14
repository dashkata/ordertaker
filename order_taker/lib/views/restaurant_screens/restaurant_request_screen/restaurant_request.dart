import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/request_status.dart';
import '../../../models/reservation_model.dart';
import '../../../providers/common_providers.dart';
import '../../../themes/themes.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_button_outlined.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_error_alert_dialog.dart';
import '../../custom_widgets/custom_progress_indicator.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../project_widgets.dart';
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
                    data: (requests) => ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: _RequestCard(
                          reservation: requests[index],
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
