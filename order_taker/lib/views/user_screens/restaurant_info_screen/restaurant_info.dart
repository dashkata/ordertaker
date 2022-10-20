import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/views/user_screens/restaurant_info_screen/controller/restaurant_info_provider.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:readmore/readmore.dart';

import '../../project_widgets.dart';
import 'restaurant_info_widget.dart';

class RestaurantInfoScreen extends ConsumerWidget {
  const RestaurantInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // final restaurantTitle = arg['restaurant'];
    // final restaurantInfo = ref.watch(restaurantInfoProvider(restaurantTitle));
    // return restaurantInfo.when(
    //   loading: () => const CircularProgressIndicator(),
    //   error: (error, stackTrace) => Text(error.toString()),
    //   data: (restaurant) => Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: appBarColor,
    //     ),
    //     floatingActionButton: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         // Padding(
    //         //   padding: const EdgeInsets.only(left: 30.0),
    //         //   child: GFButton(
    //         //     onPressed: () {
    //         //       showDialog(
    //         //         context: context,
    //         //         builder: (BuildContext context) => AlertDialog(
    //         //           backgroundColor: mainColor,
    //         //           actionsAlignment: MainAxisAlignment.start,
    //         //           actions: [
    //         //             Center(
    //         //               child: SizedBox(
    //         //                 height: 150,
    //         //                 width: 300,
    //         //                 child: Card(
    //         //                   elevation: 10,
    //         //                   color: complementaryColor,
    //         //                   child: Column(
    //         //                     crossAxisAlignment: CrossAxisAlignment.start,
    //         //                     children: [
    //         //                       Center(
    //         //                         child: Text(
    //         //                           'Order delivery or takeout',
    //         //                           style: GoogleFonts.roboto(
    //         //                             fontSize: 20,
    //         //                             fontWeight: FontWeight.bold,
    //         //                             color: accentColor,
    //         //                           ),
    //         //                         ),
    //         //                       ),
    //         //                       const Padding(
    //         //                         padding: EdgeInsets.symmetric(
    //         //                           vertical: 10.0,
    //         //                           horizontal: 10,
    //         //                         ),
    //         //                         child: InfoDivider(),
    //         //                       ),
    //         //                       Padding(
    //         //                         padding: const EdgeInsets.only(left: 10),
    //         //                         child: GFButton(
    //         //                           onPressed: () {},
    //         //                           icon: const Icon(Icons.phone),
    //         //                           text: restaurant.phoneNumber,
    //         //                           textStyle: GoogleFonts.roboto(
    //         //                             color: accentColor,
    //         //                             fontSize: 15,
    //         //                             fontWeight: FontWeight.bold,
    //         //                           ),
    //         //                           color: mainColor,
    //         //                         ),
    //         //                       ),
    //         //                     ],
    //         //                   ),
    //         //                 ),
    //         //               ),
    //         //             ),
    //         //             Padding(
    //         //               padding: const EdgeInsets.symmetric(vertical: 20.0),
    //         //               child: Center(
    //         //                 child: SizedBox(
    //         //                   height: 150,
    //         //                   width: 300,
    //         //                   child: Card(
    //         //                     elevation: 5,
    //         //                     color: complementaryColor,
    //         //                     child: Column(
    //         //                       children: [
    //         //                         Padding(
    //         //                           padding: const EdgeInsets.only(left: 10),
    //         //                           child: Row(
    //         //                             crossAxisAlignment:
    //         //                                 CrossAxisAlignment.end,
    //         //                             children: [
    //         //                               const Icon(Icons.location_on),
    //         //                               Text(
    //         //                                 restaurant.location,
    //         //                                 style: GoogleFonts.roboto(
    //         //                                   color: accentColor,
    //         //                                   fontWeight: FontWeight.bold,
    //         //                                   fontSize: 15,
    //         //                                 ),
    //         //                               ),
    //         //                             ],
    //         //                           ),
    //         //                         ),
    //         //                       ],
    //         //                     ),
    //         //                   ),
    //         //                 ),
    //         //               ),
    //         //             ),
    //         //             Column(
    //         //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         //               children: [
    //         //                 const DetailText(
    //         //                   detailTitle: 'Neighborhood',
    //         //                   detailTitleIcon: Icon(Icons.location_city),
    //         //                   detailDesc: 'Neighborhood',
    //         //                 ),
    //         //                 const SizedBox(
    //         //                   height: 20,
    //         //                 ),
    //         //                 DetailText(
    //         //                   detailTitle: 'Open hours',
    //         //                   detailTitleIcon:
    //         //                       const Icon(Icons.watch_later_outlined),
    //         //                   detailDesc: restaurant.openhours,
    //         //                 ),
    //         //                 const SizedBox(
    //         //                   height: 20,
    //         //                 ),
    //         //                 DetailText(
    //         //                   detailTitle: 'Payment options',
    //         //                   detailTitleIcon: const Icon(Icons.credit_card),
    //         //                   detailDesc: restaurant.paymentOptions,
    //         //                 ),
    //         //               ],
    //         //             )
    //         //           ],
    //         //         ),
    //         //       );
    //         //     },
    //         //     shape: GFButtonShape.pills,
    //         //     text: 'Details',
    //         //     color: complementaryColor,
    //         //     textStyle: GoogleFonts.roboto(
    //         //       color: accentColor,
    //         //       fontWeight: FontWeight.bold,
    //         //     ),
    //         //   ),
    //         // ),
    //         FloatingActionButton(
    //           backgroundColor: complementaryColor,
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) => AlertDialog(
    //                 actionsAlignment: MainAxisAlignment.start,
    //                 backgroundColor: mainColor,
    //                 title: const Center(
    //                   child: Text('Make a reservation'),
    //                 ),
    //                 actions: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Number of people',
    //                         style: GoogleFonts.roboto(
    //                           color: accentColor,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 15,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 30,
    //                         width: 400,
    //                         child: DropdownButtonHideUnderline(
    //                           child: Container(),
    //                           // GFDropdown(
    //                           //   isExpanded: true,
    //                           //   dropdownButtonColor: GFColors.TRANSPARENT,
    //                           //   onChanged: (newValue) {},
    //                           //   items: [
    //                           //     'FC Barcelona',
    //                           //     'Real Madrid',
    //                           //     'Villareal',
    //                           //     'Manchester City'
    //                           //   ]
    //                           //       .map(
    //                           //         (value) => DropdownMenuItem(
    //                           //           value: value,
    //                           //           child: Text(value),
    //                           //         ),
    //                           //       )
    //                           //       .toList(),
    //                           // ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Expanded(
    //                         child: Container(),
    //                         // DateTimePicker(
    //                         //   initialValue: '',
    //                         //   firstDate: DateTime.now(),
    //                         //   lastDate: DateTime(2100),
    //                         //   decoration: const InputDecoration(
    //                         //     labelText: 'Date',
    //                         //     labelStyle: TextStyle(
    //                         //       color: Colors.black,
    //                         //       fontSize: 15,
    //                         //     ),
    //                         //     border: InputBorder.none,
    //                         //   ),
    //                         // ),
    //                       ),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           const Text(
    //                             'Time',
    //                             style: TextStyle(color: Colors.black),
    //                           ),
    //                           SizedBox(
    //                             height: 30,
    //                             child: DropdownButtonHideUnderline(
    //                               child: Container(),
    //                               // GFDropdown(
    //                               //   dropdownButtonColor: GFColors.TRANSPARENT,
    //                               //   onChanged: (newValue) {},
    //                               //   items: [
    //                               //     'FC Barcelona',
    //                               //     'Real Madrid',
    //                               //     'Villareal',
    //                               //     'Manchester City'
    //                               //   ]
    //                               //       .map(
    //                               //         (value) => DropdownMenuItem(
    //                               //           value: value,
    //                               //           child: Text(value),
    //                               //         ),
    //                               //       )
    //                               //       .toList(),
    //                               // ),
    //                             ),
    //                           ),
    //
    //                           //dropdown,
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Center(
    //                     child: SizedBox(
    //                       width: 250,
    //                       height: 35,
    //                       child: Container(),
    //                       // GFButton(
    //                       //   onPressed: () {},
    //                       //   text: 'Find a table',
    //                       //   size: GFSize.LARGE,
    //                       //   color: complementaryColor,
    //                       //   type: GFButtonType.outline2x,
    //                       // ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //           child: const Icon(
    //             Icons.restaurant,
    //             color: accentColor,
    //           ),
    //         ),
    //       ],
    //     ),
    //     body: Stack(
    //       children: [
    //         const BackgroundWidget(),
    //         SafeArea(
    //           child: ListView(
    //             shrinkWrap: true,
    //             children: [
    //               const ButtonRow(),
    //               const InfoDivider(),
    //               Padding(
    //                 padding:
    //                     const EdgeInsets.only(bottom: 30, top: 30, left: 10),
    //                 child: Text(
    //                   restaurant.title,
    //                   style: GoogleFonts.roboto(
    //                     fontSize: 40,
    //                     fontWeight: FontWeight.bold,
    //                     fontStyle: FontStyle.italic,
    //                     color: accentColor,
    //                   ),
    //                 ),
    //               ),
    //               const InfoDivider(),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: const [
    //                   Text('Review stars'),
    //                   Text('Other stuff'),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 50,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 10.0),
    //                 child: ReadMoreText(
    //                   restaurant.overview.toUpperCase(),
    //                   colorClickableText: Colors.red,
    //                   trimMode: TrimMode.Line,
    //                   trimCollapsedText: '+ Read more',
    //                   trimExpandedText: '- Read less',
    //                   style: GoogleFonts.roboto(
    //                     color: accentColor,
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 30,
    //               ),
    //               const InfoDivider(),
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 10.0),
    //                 child: Text(
    //                   'Photos from the restaurant',
    //                   style: GoogleFonts.roboto(
    //                     color: accentColor,
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 100,
    //               ),
    //               const InfoDivider(),
    //               Center(
    //                 child: Text(
    //                   'Menu',
    //                   style: GoogleFonts.roboto(
    //                     fontSize: 36,
    //                     fontWeight: FontWeight.bold,
    //                     color: accentColor,
    //                   ),
    //                 ),
    //               ),
    //               const InfoDivider(),
    //               Center(
    //                 child: Text(
    //                   'Reviews',
    //                   style: GoogleFonts.roboto(
    //                     fontSize: 34,
    //                     fontWeight: FontWeight.bold,
    //                     color: accentColor,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
