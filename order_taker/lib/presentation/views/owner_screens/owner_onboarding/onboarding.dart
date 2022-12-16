import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:order_taker/domain/models/menu_section_model.dart';
import 'package:order_taker/presentation/providers/common_providers.dart';
import 'package:order_taker/presentation/themes/themes.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_error_alert_dialog.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_menu_card.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_progress_indicator.dart';
import 'package:order_taker/presentation/views/custom_widgets/custom_text_field.dart';

import '../../custom_widgets/add_menu_button.dart';
import '../../custom_widgets/custom_remove_focus.dart';
import 'controllers/onboarding_providers.dart';

part 'widgets/page_one_widgets/page_one_image.dart';
part 'widgets/page_one_widgets/page_one_title.dart';
part 'widgets/page_three_widgets/page_three_body.dart';
part 'widgets/page_three_widgets/page_three_title.dart';
part 'widgets/page_two_widgets/header_picture_button.dart';
part 'widgets/page_two_widgets/page_two_form.dart';
part 'widgets/page_two_widgets/page_two_title.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return RemoveFocusDetector(
      child: IntroductionScreen(
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
            footer: const AddMenuButton(),
            bodyWidget: const _PageThreeBody(),
          ),
        ],
        done: Text(
          text.done,
          style: Theme.of(context).textTheme.headline1,
        ),
        next: Text(
          text.next,
          style: Theme.of(context).textTheme.headline1,
        ),
        back: Text(
          text.back,
          style: Theme.of(context).textTheme.headline1,
        ),
        dotsDecorator: const DotsDecorator(
          color: accentBlackColor,
          activeColor: complementaryColor2,
        ),
        showBackButton: true,
        onDone: () => ref
            .read(onboardingControllerProvider.notifier)
            .submitRestaurantDetails(),
      ),
    );
  }
}
