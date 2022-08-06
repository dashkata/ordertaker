import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/confirm_reservation_providers.dart';
import 'package:order_taker/providers/restaurants_provider.dart';
import 'package:order_taker/themes/themes.dart';

class RestaurantCard extends ConsumerWidget {
  const RestaurantCard({
    required this.resTitle,
    required this.resDesc,
    required this.openHours,
    Key? key,
  }) : super(key: key);
  final String resTitle;
  final String resDesc;
  final String openHours;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue restaurantPic = ref.watch(restaurantPictureProvider(resTitle));
    return restaurantPic.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/restaurant_info',
                arguments: {"restaurant": resTitle},
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: data,
                        imageBuilder: (context, url) => Ink.image(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                          image: url,
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      resTitle,
                      style: GoogleFonts.roboto(
                          color: accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resDesc,
                          style: GoogleFonts.roboto(
                            color: accentColor,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FindATableButton(
                              resTitle: resTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    tileColor: complementaryColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}

class FindATableButton extends StatelessWidget {
  const FindATableButton({
    Key? key,
    required this.resTitle,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: GFButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
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
                      child: Consumer(builder: (context, ref, child) {
                        return GFButton(
                          color: complementaryColor,
                          shape: GFButtonShape.pills,
                          text: "Confirm reservation",
                          textStyle: GoogleFonts.roboto(
                            color: accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 10,
                          onPressed: () {
                            if (ref.read(userDateProvider) != "" &&
                                ref.read(peopleProvider) != 0) {
                              Navigator.popAndPushNamed(
                                  context, "/confirm_reservation",
                                  arguments: {
                                    "restaurantTitle": resTitle,
                                    "userDate": ref.read(userDateProvider),
                                    "numberOfPeople": ref.read(peopleProvider)
                                  });
                              // Navigator.pop(context);
                            }
                          },
                        );
                      }),
                    ),
                  ],
                );
              });
        },
        elevation: 10,
        shape: GFButtonShape.pills,
        text: "Find a Table",
        color: mainColor,
        textStyle: GoogleFonts.roboto(
          color: accentColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NumberOfPeopleWidget extends ConsumerWidget {
  const NumberOfPeopleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: (value) => ref
              .watch(peopleProvider.notifier)
              .update((state) => int.parse(value)),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            helperText: "Enter the number of people.",
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class SelectDateWidget extends ConsumerWidget {
  const SelectDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          helperText: "Select a date for your reservation",
          hintText: ref.watch(userDateProvider),
        ),
        onTap: () async {
          var userDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              builder: (BuildContext content, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: complementaryColor,
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary),
                    colorScheme:
                        const ColorScheme.light(primary: complementaryColor)
                            .copyWith(secondary: complementaryColor),
                  ),
                  child: child!,
                );
              });

          if (userDate != null) {
            var userTime = await showTimePicker(
              builder: (context, child) {
                return Theme(
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
                );
              },
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (userTime != null) {
              ref
                  .read(confirmDateProvider.notifier)
                  .update((state) => DateFormat("E, MMM d").format(userDate));
              ref
                  .read(confirmTimeProvider.notifier)
                  .update((state) => userTime.format(context));
              ref.read(userDateProvider.notifier).update((state) =>
                  DateFormat('EEEE, MMMM d, y - HH:mm a').format(DateTime(
                      userDate.year,
                      userDate.month,
                      userDate.day,
                      userTime.hour,
                      userTime.minute)));
            }
          }
          return;
        },
      ),
    );
  }
}
