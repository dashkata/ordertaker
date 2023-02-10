import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../../custom_widgets/custom_error_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import '../../confirm_reservation_screen/confirm_reservation_arguments.dart';
import '../../confirm_reservation_screen/controllers/confirm_reservation_providers.dart';
import 'restaurant_screen_providers.dart';

class RestaurantScreenViewModel extends AutoDisposeNotifier<void> {
  RestaurantScreenViewModel() : super();

  bool _timeValidation({
    required Restaurant restaurant,
    required DateTime dateTime,
  }) {
    final String openHour =
        restaurant.openHours.replaceAll(' ', '').split('-')[0];
    final String closeHour =
        restaurant.openHours.replaceAll(' ', '').split('-')[1];
    final TimeOfDay openTimeHour = TimeOfDay(
      hour: int.parse(openHour.split(':')[0]),
      minute: int.parse(openHour.split(':')[1]),
    );
    final TimeOfDay closeTimeHour = TimeOfDay(
      hour: int.parse(closeHour.split(':')[0]),
      minute: int.parse(closeHour.split(':')[1]),
    );
    if ((openTimeHour.hour * 60 + openTimeHour.minute) <
            (dateTime.hour * 60 + dateTime.minute) &&
        (closeTimeHour.hour * 60 + closeTimeHour.minute) >
            (dateTime.hour * 60 + dateTime.minute) &&
        dateTime.isAfter(DateTime.now())) {
      return true;
    }
    return false;
  }

  Future<void> showDateTimePicker({required Restaurant restaurant}) async {
    final context = navigatorKey.currentState!.context;
    final text = AppLocalizations.of(context)!;
    final userDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext content, child) => dateCalendarTheme(child!),
    );
    if (userDate != null) {
      final userTime = await showTimePicker(
        helpText: '${text.enter_time} ${restaurant.openHours}',
        builder: (context, child) => timeCalendarTheme(child!),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (userTime != null &&
          _timeValidation(
            restaurant: restaurant,
            dateTime: DateTime(
              userDate.year,
              userDate.month,
              userDate.day,
              userTime.hour,
              userTime.minute,
            ),
          )) {
        ref
            .read(confirmDateProvider.notifier)
            .update((state) => DateFormat('E, MMM d').format(userDate));
        ref
            .read(confirmTimeProvider.notifier)
            .update((state) => userTime.format(context));
        ref.read(userDateProvider.notifier).update(
              (state) => DateFormat('EEEE, MMMM d, y - HH:mm a').format(
                DateTime(
                  userDate.year,
                  userDate.month,
                  userDate.day,
                  userTime.hour,
                  userTime.minute,
                ),
              ),
            );
      } else {
        await showDialog(
          context: context,
          builder: (_) => ErrorAlertDialog(
            errorMessage: text.invalid_date,
          ),
        );
      }
    }
    return;
  }

  Future<void> navigateToConfirm({
    required Restaurant restaurant,
  }) async {
    await navigatorKey.currentState!.pushNamed(
      Routes.userConfirmReserveration,
      arguments: ConfirmReservationArguments(
        restaurant: restaurant,
        userDate: ref.read(userDateProvider),
        numberOfPeople: ref.read(peopleProvider),
        preferredLocation:
            ref.read(preferredLocationProvider) == 0 ? 'inside' : 'outside',
      ),
    );
  }

  void showDetailsDialog({
    required Widget alertDialog,
  }) {
    showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) => alertDialog,
    );
  }

  Future<void> navigateToRestaurantInfo({
    required Restaurant restaurant,
  }) async {
    await navigatorKey.currentState!.pushNamed(
      Routes.ownerRestaurantInfo,
      arguments: restaurant,
    );
  }

  @override
  void build() {
    // TODO: implement build
  }
}
