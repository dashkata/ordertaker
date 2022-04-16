import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/UserScreens/confirmreservationpage/confirm_reservation_widget.dart';
import 'package:order_taker/Screens/UserScreens/restaurantinfopage/restaurant_info_widget.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class ConfirmReservation extends StatefulWidget {
  const ConfirmReservation({Key? key}) : super(key: key);

  @override
  State<ConfirmReservation> createState() => _ConfirmReservationState();
}

class _ConfirmReservationState extends State<ConfirmReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: contentContainerDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GFListTile(
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        avatar: GFAvatar(
                          backgroundImage:
                              const AssetImage('Assets/PizzaDonVito.jpg'),
                          shape: GFAvatarShape.square,
                          borderRadius: BorderRadius.circular(10),
                          radius: 30,
                        ),
                        title: Text(
                          "Pizza Don Vito",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: accentColor,
                          ),
                        ),
                        subTitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 15,
                              color: accentColor,
                            ),
                            Text(
                              "Thu, Apr 21",
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: accentColor,
                              ),
                            ),
                            const Icon(
                              Icons.watch_later_outlined,
                              size: 15,
                              color: accentColor,
                            ),
                            Text(
                              "12:45 PM",
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: accentColor,
                              ),
                            ),
                            const Icon(
                              Icons.person,
                              size: 15,
                              color: accentColor,
                            ),
                            Text(
                              "6 people",
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      const InfoDivider(),
                      Row(
                        children: const [
                          UserDetail(
                            detailType: "First Name",
                            userDetail: "Alexander",
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: UserDetail(
                              detailType: "Last Name",
                              userDetail: "Georgiev",
                            ),
                          )
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: UserDetail(
                          detailType: "Email Address",
                          userDetail: "alexandergeorgiev04@gmail.com",
                        ),
                      ),

                      const UserDetail(
                        detailType: "Mobile Number",
                        userDetail: "089 783 4668",
                      ),

                      Center(
                        child: NormalButtons(
                            buttonText: "Confirm Reservation",
                            buttonFunc: () {}),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: NormalButtons(
                              buttonText: "Change Details", buttonFunc: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
