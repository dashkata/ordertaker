import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../models/restaurant_model.dart';
import '../../../../themes/themes.dart';
import '../../../project_widgets.dart';
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
            (dateTime.hour * 60 + openTimeHour.minute) &&
        (closeTimeHour.hour * 60 + closeTimeHour.minute) >
            (dateTime.hour * 60 + openTimeHour.minute) &&
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

  Future<void> showTableDialog(
    Widget tablesDialog,
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (_) => tablesDialog,
    );
  }

  Future<void> navigateToConfirm(
    String restaurantTitle,
    WidgetRef ref,
    String selectedTable,
  ) async {
    final tableId = int.parse(
      selectedTable.substring('Table '.length, 'Table '.length + 1),
    );
    await navigatorKey.currentState!.pushNamed(
      Routes.userConfirmReserveration,
      arguments: ConfirmReservationArguments(
        restaurantTitle: restaurantTitle,
        userDate: ref.read(userDateProvider),
        numberOfPeople: ref.read(peopleProvider),
        tableId: tableId,
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

  void navigateToRestaurantInfo(String restaurantTitle) {
    navigatorKey.currentState!.pushNamed(
      Routes.userRestaurantInfo,
      arguments: restaurantTitle,
    );
  }
}
