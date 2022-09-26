import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../Themes/themes.dart';
import '../../../../providers/confirm_reservation_providers.dart';
import '../../../../providers/controller_providers.dart';
import '../../../../providers/repository_providers.dart';
import '../../../../providers/user_restaurant_providers.dart';
import '../../../project_widgets.dart';
import '../../../resources/route_manager.dart';
import '../widgets/free_tables.dart';
import '../widgets/number_of_people.dart';
import '../widgets/select_date.dart';

class RestaurantDialogNotifier extends StateNotifier<void> {
  RestaurantDialogNotifier() : super(null);

  Future<void> showDateTimePicker(BuildContext context, WidgetRef ref) async {
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
        builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              // change the border color
              primary: mainColor,
              // change the text color
              onSurface: accentColor,
            ),
            // button colors
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: accentColor,
              ),
            ),
          ),
          child: child!,
        ),
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (userTime != null) {
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
      }
    }
    return;
  }

  Future<void> confirmReservation(
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
    await navigatorKey.currentState!.pushNamed(
      Routes.userConfirmReserveration,
      arguments: {
        'restaurantTitle': restaurantTitle,
        'userDate': ref.read(userDateProvider),
        'numberOfPeople': ref.read(peopleProvider),
        'tableId': selectedTable,
      },
    );
  }

  void showDetailsDialog(BuildContext context, String resTitle, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: mainColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SelectDateWidget(),
            NumberOfPeopleWidget(),
          ],
        ),
        actions: [
          Center(
            child: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: () => ref
                    .read(restaurantDialogNotifierProvider.notifier)
                    .confirmReservation(ref, resTitle, context),
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
