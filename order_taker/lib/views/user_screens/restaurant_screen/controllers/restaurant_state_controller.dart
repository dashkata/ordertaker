import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/views/resources/route_manager.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/widgets/number_of_people.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/widgets/select_date.dart';

import '../../../../providers/confirm_reservation_providers.dart';
import '../../../../providers/user_restaurant_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  void confirmReservation(WidgetRef ref, String resTitle) {
    if (ref.read(userDateProvider) != '' && ref.read(peopleProvider) != 0) {
      navigatorKey.currentState!.pushNamed(
        Routes.userConfirmReserveration,
        arguments: {
          'restaurantTitle': resTitle,
          'userDate': ref.read(userDateProvider),
          'numberOfPeople': ref.read(peopleProvider)
        },
      );
      // Navigator.pop(context);
    }
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
              builder: (context, ref, child) => GFButton(
                color: complementaryColor,
                shape: GFButtonShape.pills,
                text: 'Confirm reservation',
                textStyle: GoogleFonts.roboto(
                  color: accentColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 10,
                onPressed: () => ref
                    .read(restaurantDialogNotifierProvider.notifier)
                    .confirmReservation(ref, resTitle),
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
