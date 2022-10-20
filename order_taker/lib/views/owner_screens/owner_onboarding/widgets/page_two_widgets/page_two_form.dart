part of '../../onboarding.dart';

class _PageTwoForm extends ConsumerWidget {
  const _PageTwoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextFields(
          hintText: text.restaurant_address,
          icon: Icons.location_city,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.streetAddress,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantAddressProvider,
                    val,
                  ),
        ),
        TextFields(
          hintText: text.restaurant_working_hours,
          icon: Icons.watch_later,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.none,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantHoursProvider,
                    val,
                  ),
        ),
        TextFields(
          hintText: text.restaurant_website,
          icon: Icons.web,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.url,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantWebsiteProvider,
                    val,
                  ),
        ),
        TextFields(
          hintText: text.restaurant_phone_number,
          icon: Icons.phone,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.phone,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantPhoneNumberProvider,
                    val,
                  ),
        ),
        TextFields(
          hintText: text.restaurant_descriptions,
          icon: Icons.note_alt_sharp,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.text,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantDescriptionProvider,
                    val,
                  ),
        ),
        TextFields(
          hintText: text.restaurant_descriptions,
          icon: Icons.payment,
          obscure: false,
          textInputAction: TextInputAction.done,
          inputType: TextInputType.text,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantPaymentProvider,
                    val,
                  ),
        ),
        TextFields(
          func: (value) =>
              ref.read(restaurantOutsideTablesProvider.notifier).update(
                    (state) => value,
                  ),
          inputType: TextInputType.number,
          icon: Icons.table_bar,
          hintText: 'How many tables are outside?',
          obscure: false,
          textInputAction: TextInputAction.next,
        ),
        TextFields(
          func: (value) =>
              ref.read(restaurantInsideTablesProvider.notifier).update(
                    (state) => value,
                  ),
          inputType: TextInputType.number,
          icon: Icons.table_restaurant,
          hintText: 'How many tables are inside?',
          obscure: false,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
