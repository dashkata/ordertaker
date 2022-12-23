import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/domain/models/reservation_model.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../custom_widgets/custom_button.dart';
import '../../resources/padding_manager.dart';
import '../../resources/style_manager.dart';
import 'confirm_reservation_arguments.dart';
import 'controllers/confirm_reservation_providers.dart';

part 'widgets/confirm_button.dart';
part 'widgets/confirm_overview.dart';
part 'widgets/detail_row.dart';
part 'widgets/user_detail.dart';

class ConfirmReservationScreen extends ConsumerWidget {
  const ConfirmReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    final AsyncValue userDetails = ref.watch(detailsProvider);
    final reservationInfo = ModalRoute.of(context)!.settings.arguments
        as ConfirmReservationArguments;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: PaddingManager.p7,
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: contentContainerDecoration,
              child: userDetails.when(
                data: (data) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ConfirmOverview(
                        reservationInfo: reservationInfo,
                        text: text,
                      ),
                      _UserDetail(
                        detailType: text.name,
                        userDetail: data['name'],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: _UserDetail(
                          detailType: text.email_address,
                          userDetail: data['email'],
                        ),
                      ),
                      _UserDetail(
                        detailType: text.mobile_number,
                        userDetail: data['phoneNumber'],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: _ConfirmButton(
                          text: text,
                          reservationInfo: reservationInfo,
                          name: data['name'],
                        ),
                      ),
                    ],
                  ),
                ),
                error: (e, s) => Text(e.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
