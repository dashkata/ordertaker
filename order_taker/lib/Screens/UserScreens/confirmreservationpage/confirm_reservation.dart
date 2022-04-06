import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/UserScreens/confirmreservationpage/confirm_reservation_widget.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFCard(
                  titlePosition: GFPosition.start,
                  color: cardColor,
                  title: const GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('Assets/PizzaDonVito.jpg'),
                    ),
                    titleText: "Pizza Don Vito",
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.calendar_month),
                      Text("Thu, Apr 21"),
                      Icon(Icons.watch_later_outlined),
                      Text("12:45 PM"),
                      Icon(Icons.person),
                      Text("6 people"),
                    ],
                  ),
                ),
                const UserDetails(
                  userDetail: "Alexander Georgiev",
                  buttonText: "Change name",
                ),
                const UserDetails(
                  userDetail: "alex@abv.bg",
                  buttonText: "Change email",
                ),
                const UserDetails(
                  userDetail: "08977832321",
                  buttonText: "Change phone number",
                ),
                SizedBox(
                  width: 350,
                  child: GFButton(
                    onPressed: () {},
                    text: "Complete reservation",
                    color: buttonColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
