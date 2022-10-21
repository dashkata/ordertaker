import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_progress_indicator.dart';
import '../../../project_widgets.dart';
import '../../../resources/route_manager.dart';
import '../../confirm_reservation_screen/confirm_reservation_arguments.dart';
import '../../confirm_reservation_screen/controllers/confirm_reservation_providers.dart';
import '../restaurants.dart';
import 'restaurant_screen_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          colorScheme: const ColorScheme.light(primary: complementaryColor2)
              .copyWith(secondary: complementaryColor2),
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
              primary: complementaryColor2,
              onSurface: accentBlackColor,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: accentBlackColor,
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
    final text = AppLocalizations.of(context)!;
    if (ref.read(userDateProvider) != '' && ref.read(peopleProvider) != 0) {
      await showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: Center(
            child: Text(
              text.available_tables,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          content: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final AsyncValue<Map<String, bool>> availableTables =
                  ref.watch(fetchFreeTablesProvider(resTitle));
              return availableTables.when(
                data: (tables) => SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: tables.length,
                        itemBuilder: (context, index) => CustomButton(
                          buttonText: tables.keys.elementAt(index),
                          buttonFunc: tables.values.elementAt(index)
                              ? () => ref
                                  .read(
                                      restaurantDialogNotifierProvider.notifier)
                                  .navigateToConfirm(
                                    resTitle,
                                    ref,
                                    tables.keys.elementAt(index),
                                  )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                error: (e, s) => Text(e.toString()),
                loading: () => const CustomProgressIndicator(),
              );
            },
          ),
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
      builder: (BuildContext context) => CustomAlertDialog(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Consumer(
                builder: (context, ref, child) => ElevatedButton(
                  onPressed: () =>
                      _confirmReservation(ref, restaurant.title, context),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: complementaryColor2,
                    // elevation: 10,
                  ),
                  child: Text(
                    'Confirm reservation',
                    style: Theme.of(context).textTheme.headline4,
                  ),
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
