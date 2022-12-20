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
        CustomTextField(
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
        CustomTextField(
          hintText: text.restaurant_working_hours,
          icon: Icons.watch_later,
          obscure: false,
          textInputAction: TextInputAction.next,
          inputType: TextInputType.text,
          func: (val) =>
              ref.read(onboardingControllerProvider.notifier).updateTextField(
                    restaurantHoursProvider,
                    val,
                  ),
        ),
        CustomTextField(
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
        CustomTextField(
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
        CustomTextField(
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
        CustomTextField(
          hintText: 'Restaurant payment methods',
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
        CustomTextField(
          func: (value) => ref.read(restaurantTablesProvider.notifier).update(
                (state) => value,
              ),
          inputType: TextInputType.number,
          icon: Icons.table_bar,
          hintText: text.outside_tables,
          obscure: false,
          textInputAction: TextInputAction.next,
        ),
        const _HeaderPictureButton(),
      ],
    );
  }
}