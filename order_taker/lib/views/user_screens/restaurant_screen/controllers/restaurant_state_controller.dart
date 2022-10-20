import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../Themes/themes.dart';
import '../../../../models/restaurant_model.dart';
import '../../../project_widgets.dart';
import '../../../resources/route_manager.dart';
import '../../confirm_reservation_screen/confirm_reservation_arguments.dart';
import '../../confirm_reservation_screen/controllers/confirm_reservation_providers.dart';
import '../restaurants.dart';
import 'restaurant_screen_providers.dart';

class RestaurantDialogNotifier extends StateNotifier<void> {
  RestaurantDialogNotifier() : super(null);

  bool timeValidation(Restaurant restaurant, DateTime dateTime) {
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
      builder: (BuildContext content, child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: complementaryColor,
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme: const ColorScheme.light(primary: complementaryColor)
              .copyWith(secondary: complementaryColor),
        ),
        child: child!,
      ),
    );
    if (userDate != null) {
      final userTime = await showTimePicker(
        helpText: 'Enter time between ${restaurant.openHours}',
        builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: mainColor,
              onSurface: accentColor,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: accentColor,
              ),
            ),
          ),
          child: child!,
        ),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (userTime != null &&
          timeValidation(
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

  Future<void> _confirmReservation(
    WidgetRef ref,
    String resTitle,
    BuildContext context,
  ) async {
    if (ref.read(userDateProvider) != '' && ref.read(peopleProvider) != 0) {
      await showDialog(
        context: context,
        builder: (_) => TablesAlertDialog(
          restaurantTitle: resTitle,
        ),
      );
    }
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
      BuildContext context, Restaurant restaurant, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: mainColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectDateWidget(
              restaurant: restaurant,
            ),
            const NumberOfPeopleWidget(),
          ],
        ),
        actions: [
          Center(
            child: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: () =>
                    _confirmReservation(ref, restaurant.title, context),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: complementaryColor,
                  elevation: 10,
                ),
                child: Text(
                  'Confirm reservation',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToRestaurantInfo(String restaurantTitle) {
    navigatorKey.currentState!.pushNamed(
      Routes.userRestaurantInfo,
      arguments: restaurantTitle,
    );
  }
}
