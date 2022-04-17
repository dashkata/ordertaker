import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:order_taker/Screens/UserScreens/restaurantinfopage/restaurant_info_widget.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:readmore/readmore.dart';

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({Key? key}) : super(key: key);

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: GFButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: mainColor,
                      actionsAlignment: MainAxisAlignment.start,
                      actions: [
                        Center(
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Card(
                              elevation: 10,
                              color: complementaryColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Order delivery or takeout",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10),
                                    child: InfoDivider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GFButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.phone),
                                      text: "restaurant phone number",
                                      textStyle: GoogleFonts.roboto(
                                        color: accentColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: SizedBox(
                              height: 150,
                              width: 300,
                              child: Card(
                                elevation: 5,
                                color: complementaryColor,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.location_on),
                                          Text(
                                            "The location of the restaurant",
                                            style: GoogleFonts.roboto(
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            DetailText(
                              detailTitle: "Neighborhood",
                              detailTitleIcon: Icon(Icons.location_city),
                              detailDesc: "Neighborhood",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DetailText(
                              detailTitle: "Open hours",
                              detailTitleIcon: Icon(Icons.watch_later_outlined),
                              detailDesc: "open hours",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DetailText(
                              detailTitle: "Payment options",
                              detailTitleIcon: Icon(Icons.credit_card),
                              detailDesc: "Visa, Mastercard",
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              shape: GFButtonShape.pills,
              text: "Details",
              color: complementaryColor,
              textStyle: GoogleFonts.roboto(
                color: accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: complementaryColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.start,
                      backgroundColor: mainColor,
                      title: const Center(
                        child: Text("Make a reservation"),
                      ),
                      actions: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Number of people",
                              style: GoogleFonts.roboto(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 400,
                              child: DropdownButtonHideUnderline(
                                child: GFDropdown(
                                  isExpanded: true,
                                  dropdownButtonColor: GFColors.TRANSPARENT,
                                  onChanged: (newValue) {},
                                  items: [
                                    'FC Barcelona',
                                    'Real Madrid',
                                    'Villareal',
                                    'Manchester City'
                                  ]
                                      .map((value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(value),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),

                            //dropdown,
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: DateTimePicker(
                                initialValue: '',
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                decoration: const InputDecoration(
                                  labelText: "Date",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: DropdownButtonHideUnderline(
                                    child: GFDropdown(
                                      dropdownButtonColor: GFColors.TRANSPARENT,
                                      onChanged: (newValue) {},
                                      items: [
                                        'FC Barcelona',
                                        'Real Madrid',
                                        'Villareal',
                                        'Manchester City'
                                      ]
                                          .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),

                                //dropdown,
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 35,
                            child: GFButton(
                              onPressed: () {},
                              text: "Find a table",
                              size: GFSize.LARGE,
                              color: complementaryColor,
                              type: GFButtonType.outline2x,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.restaurant,
              color: accentColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                const ButtonRow(),
                const InfoDivider(),
                Padding(
                  padding: EdgeInsets.only(bottom: 30, top: 30, left: 10),
                  child: Text(
                    "Pizza Don Vito",
                    style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: accentColor,
                    ),
                  ),
                ),
                const InfoDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text("Review stars"),
                    Text("Other stuff"),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ReadMoreText(
                    "WELCOME TO BESTIA, THE HUNGARIAN BEAST. THE PLACE OF QUALITY STEAKS, HUGE SELECTION OF CRAFT LOCAL BEERS AND LIVE MUSIC PROGRAMS, RIGHT NEXT TO THE GORGEOUS BASILICA. IF YOU WISH TO SKIP ORDINARY WE OFFER SOME SPECIAL BAR STYLE SEATING EITHER, IN FRONT OF OUR OPEN KITCHEN, GIVING THE GUESTS A UNIQUE VIEW OF OUR TALENTED CHEFS CREATING MEALS FROM SCRATCH.",
                    trimLines: 2,
                    colorClickableText: Colors.red,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '+ Read more',
                    trimExpandedText: '- Read less',
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const InfoDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Photos from the restaurant",
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const InfoDivider(),
                Center(
                  child: Text(
                    "Menu",
                    style: GoogleFonts.roboto(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                const InfoDivider(),
                Center(
                  child: Text(
                    "Reviews",
                    style: GoogleFonts.roboto(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}