import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:order_taker/views/project_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  //address, open hours, payment methods, website, phone number

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Center(
            child: Image.asset(
              'assets/Logo2.0.png',
              height: 400,
            ),
          ),
          titleWidget: Text(
            'Welcome to order taker!',
            style: Theme.of(context).textTheme.headline5,
          ),
          body: '',
        ),
        PageViewModel(
          titleWidget: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Text(
                'We need some details about your restaurant.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          bodyWidget: Form(
            child: Column(
              children: [
                TextFields(
                  hintText: 'Restaurant address',
                  icon: Icons.location_city,
                  obscure: false,
                  inputType: TextInputType.streetAddress,
                  func: (val) {},
                ),
                TextFields(
                  hintText: 'Restaurant working hours',
                  icon: Icons.watch_later,
                  obscure: false,
                  inputType: TextInputType.none,
                  func: (val) {},
                ),
                TextFields(
                  hintText: 'Restaurant website',
                  icon: Icons.web,
                  obscure: false,
                  inputType: TextInputType.streetAddress,
                  func: (val) {},
                ),
                TextFields(
                  hintText: 'Restaurant phone number',
                  icon: Icons.phone,
                  obscure: false,
                  inputType: TextInputType.phone,
                  func: (val) {},
                )
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Text(
                'Add the menu for your restaurant.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          bodyWidget: Column(
            children: [
              NormalButtons(
                buttonText: 'Add a menu item',
                buttonFunc: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Center(
                      child: Text(
                        'Add a menu item',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    content: Column(

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      done: const Text(
        'Done',
      ),
      next: const Text(
        'Next',
      ),
      back: const Text(
        'Back',
      ),
      showBackButton: true,
      onDone: () {},
    );
  }
}
