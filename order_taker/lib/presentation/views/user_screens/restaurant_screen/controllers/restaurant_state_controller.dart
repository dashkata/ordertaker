import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:order_taker/domain/models/restaurant_model.dart';
import 'package:order_taker/presentation/themes/themes.dart';

import '../../../custom_widgets/custom_error_alert_dialog.dart';
import '../../../resources/route_manager.dart';
import '../../confirm_reservation_screen/confirm_reservation_arguments.dart';
import '../../confirm_reservation_screen/controllers/confirm_reservation_providers.dart';
import 'restaurant_screen_providers.dart';

class RestaurantScreenController extends StateNotifier<void> {
  RestaurantScreenController() : super(null);

  bool _timeValidation(Restaurant restaurant, DateTime dateTime) {
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

  Future<void> showDateTimePicker(
      BuildContext context, WidgetRef ref, Restaurant restaurant) async {
    final userDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext content, child) => dateCalendarTheme(child!),
    );
    if (userDate != null) {
      final userTime = await showTimePicker(
        helpText: 'Enter time between ${restaurant.openHours}',
        builder: (context, child) => timeCalendarTheme(child!),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (userTime != null &&
          _timeValidation(
            restaurant,
            DateTime(
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
          builder: (_) => const ErrorAlertDialog(
            errorMessage: 'The date you selected is invalid, try to select '
                'a time in the working hours of the restaurant!',
          ),
        );
      }
    }
    return;
  }

  Future<void> navigateToConfirm(
    Restaurant restaurant,
    WidgetRef ref,
  ) async {
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

  void showDetailsDialog(
    BuildContext context,
    Widget alertDialog,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }

  void navigateToRestaurantInfo({required Restaurant restaurant}) {
    navigatorKey.currentState!.pushNamed(
      Routes.ownerRestaurantInfo,
      arguments: restaurant,
    );
  }
}
