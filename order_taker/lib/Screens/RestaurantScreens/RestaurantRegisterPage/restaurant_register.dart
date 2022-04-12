import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/Screens/RestaurantScreens/RestaurantRegisterPage/restaurant_register_widgets.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:order_taker/Themes/themes.dart';

class RestaurantRegister extends StatelessWidget {
  const RestaurantRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                        child: Text(
                          "Register a restaurant",
                          style: GoogleFonts.roboto(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: complementaryColor,
                        ),
                        width: double.infinity,
                        height: 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: DoubleTextField(
                                      hintText: "First Name",
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: DoubleTextField(
                                      hintText: "Last Name",
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const TextFields(
                              hintText: "Email Address",
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            const TextFields(
                              hintText: "Mobile Number",
                              icon: Icons.phone,
                              obscure: false,
                              inputType: TextInputType.number,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.0, top: 15),
                                    child: RestaurantFields(
                                      hintText: "Restaurant Name",
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 20.0, top: 15),
                                    child: RestaurantFields(
                                      hintText: "Restaurant City",
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.0, top: 15),
                                    child: RestaurantFields(
                                      hintText: "Restaurant Zip",
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 20.0, top: 15),
                                    child: RestaurantFields(
                                      hintText: "Restaurant Country",
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: NormalButtons(
                                  buttonText: "Get Started", buttonFunc: () {}),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
