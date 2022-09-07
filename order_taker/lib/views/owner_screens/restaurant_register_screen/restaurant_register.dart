import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/repository_providers.dart';
import '../../../providers/restaurant_register_provider.dart';
import '../../../themes/themes.dart';

import '../../project_widgets.dart';

class RestaurantRegister extends ConsumerWidget {
  const RestaurantRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(restaurantFirstNameProvider);
    final lastName = ref.watch(restaurantLastNameProvider);
    final email = ref.watch(restaurantEmailProvider);
    final password = ref.watch(restaurantPasswordProvider);
    final phoneNumber = ref.watch(restaurantPhoneProvider);
    final restaurantName = ref.watch(restaurantNameProvider);
    final auth = ref.watch(authRepositoryProvider);
    final db = ref.watch(firestoreRepositoryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.popAndPushNamed(context, '/register'),
        backgroundColor: complementaryColor,
        child: const Icon(
          Icons.arrow_back,
          color: accentColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Stack(
        children: [
          const BackgroundWidgetAuthPages(),
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
                          'Register a restaurant',
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
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: DoubleTextField(
                                      func: (value) {
                                        ref
                                            .read(
                                              restaurantFirstNameProvider
                                                  .notifier,
                                            )
                                            .update((state) => value);
                                      },
                                      hintText: 'First Name',
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: DoubleTextField(
                                      func: (value) {
                                        ref
                                            .read(
                                              restaurantLastNameProvider
                                                  .notifier,
                                            )
                                            .update((state) => value);
                                      },
                                      hintText: 'Last Name',
                                      icon: Icons.person,
                                      obscure: false,
                                      inputType: TextInputType.name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFields(
                              func: (value) {
                                ref
                                    .read(restaurantEmailProvider.notifier)
                                    .update((state) => value);
                              },
                              hintText: 'Email Address',
                              icon: Icons.mail,
                              obscure: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            TextFields(
                              hintText: 'Password',
                              icon: Icons.password,
                              obscure: true,
                              inputType: TextInputType.text,
                              func: (value) {
                                ref
                                    .read(restaurantPasswordProvider.notifier)
                                    .update((state) => value);
                              },
                            ),
                            TextFields(
                              func: (value) {
                                ref
                                    .read(restaurantPhoneProvider.notifier)
                                    .update((state) => value);
                              },
                              hintText: 'Mobile Number',
                              icon: Icons.phone,
                              obscure: false,
                              inputType: TextInputType.number,
                            ),
                            TextFields(
                              hintText: 'Restaurant name',
                              inputType: TextInputType.text,
                              icon: Icons.restaurant,
                              obscure: false,
                              func: (value) {
                                ref
                                    .read(restaurantNameProvider.notifier)
                                    .update((state) => value);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: NormalButtons(
                                buttonText: 'Get Started',
                                buttonFunc: () async {
                                  await auth
                                      .signUp(
                                        email: email,
                                        password: password,
                                      )
                                      .then(
                                        (value) => auth
                                            .getCurrentUser()!
                                            .sendEmailVerification(),
                                      )
                                      .then(
                                        (value) => db.setMobileNumber(
                                          auth.getCurrentUser()!.uid,
                                          phoneNumber,
                                        ),
                                      )
                                      .then(
                                        (value) => db
                                            .setRestaurantName(restaurantName),
                                      )
                                      .then(
                                        (value) => db.setUserType(
                                          'Admin',
                                          auth.getCurrentUser()!.uid,
                                        ),
                                      )
                                      .then(
                                        (value) => auth.updateUserName(
                                          name: '$firstName $lastName',
                                        ),
                                      );
                                  await Navigator.popAndPushNamed(
                                    context,
                                    '/login',
                                  );
                                },
                              ),
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
