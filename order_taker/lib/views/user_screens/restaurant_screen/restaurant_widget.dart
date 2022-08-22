import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/user_restaurant_providers.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/resources/padding_manager.dart';

import '../../../models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.p1,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/restaurant_info',
            arguments: {"restaurant": restaurant.title},
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
                  Consumer(builder: (context, ref, child) {
                    AsyncValue restaurantPic =
                        ref.watch(restaurantPictureProvider(restaurant.title));
                    return restaurantPic.when(
                        data: (imageUrl) => CachedNetworkImage(
                              imageUrl: restaurantPic.value,
                              imageBuilder: (context, url) => Ink.image(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.8),
                                    BlendMode.dstATop),
                                image: url,
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                            ),
                        error: (e, s) =>
                            GFToast.showToast(e.toString(), context),
                        loading: () => const LoadingIndicator());
                    // return Container();
                  }),
                ],
              ),
              ListTile(
                title: Text(
                  restaurant.title,
                  style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.desc,
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
                          resTitle: restaurant.title,
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
  }
}

class FindATableButton extends ConsumerWidget {
  const FindATableButton({
    Key? key,
    required this.resTitle,
  }) : super(key: key);

  final String resTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 150,
      child: GFButton(
        onPressed: () {
          ref
              .read(restaurantDialogNotifierProvider.notifier)
              .showDetailsDialog(context, resTitle, ref);
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
      padding: PaddingManager.p2,
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: (value) => ref
              .watch(peopleProvider.notifier)
              .update((state) => int.parse(value)),
          decoration: InputDecoration(
            contentPadding: PaddingManager.p3,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          contentPadding: PaddingManager.p3,
          helperText: "Select a date for your reservation",
          hintText: ref.watch(userDateProvider),
        ),
        onTap: () async => ref
            .read(restaurantDialogNotifierProvider.notifier)
            .showDateTimePicker(context, ref),
      ),
    );
  }
}
