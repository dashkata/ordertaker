import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:order_taker/themes/themes.dart';
import 'package:order_taker/views/project_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

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
          body: 'text fieldove',
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
