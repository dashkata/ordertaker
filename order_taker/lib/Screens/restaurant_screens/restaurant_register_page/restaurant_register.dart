import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/screens/restaurant_screens/restaurant_register_page/restaurant_register_widgets.dart';
import 'package:order_taker/screens/project_widgets.dart';
import 'package:order_taker/themes/themes.dart';

class RestaurantRegister extends StatelessWidget {
  const RestaurantRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.popAndPushNamed(context, '/register'),
        backgroundColor: complementaryColor,
        child: Icon(
          Icons.arrow_back,
          color: accentColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
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
                            fontSize: 28,
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
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        decoration: contentContainerDecoration,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: DoubleTextField(
                                      func: (value) {},
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
                                      func: (value) {},
                                      hintText: "Last Name",
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFields(
                              func: (value) {},
                              hintText: "Email Address",
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            TextFields(
                              func: (value) {},
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
