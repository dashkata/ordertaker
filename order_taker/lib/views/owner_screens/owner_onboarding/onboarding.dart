import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../enums/image_type.dart';
import '../../../models/menu_item_model.dart';
import '../../../models/menu_section_model.dart';
import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controllers/onboarding_providers.dart';

part 'widgets/page_one_widgets/page_one_image.dart';

part 'widgets/page_one_widgets/page_one_title.dart';

part 'widgets/page_two_widgets/page_two_title.dart';

part 'widgets/page_two_widgets/page_two_form.dart';

part 'widgets/page_three_widgets/page_three_title.dart';

part 'widgets/page_three_widgets/page_three_add_button.dart';

part 'widgets/page_three_widgets/page_three_body.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => IntroductionScreen(
        pages: [
          PageViewModel(
            image: const _PageOneImage(),
            titleWidget: const _PageOneTitle(),
            body: '',
          ),
          PageViewModel(
            titleWidget: const _PageTwoTitle(),
            bodyWidget: const _PageTwoForm(),
          ),
          PageViewModel(
            titleWidget: const _PageThreeTitle(),
            footer: const _PageThreeButton(),
            bodyWidget: const _PageThreeBody(),
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
        onDone: () => ref
            .read(onboardingControllerProvider.notifier)
            .submitRestaurantDetails(),
      );
}
