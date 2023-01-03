part of '../../onboarding.dart';

class _PageTwoForm extends ConsumerWidget {
  const _PageTwoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            hintText: text.restaurant_address,
            icon: Icons.location_city,
            obscure: false,
            textInputAction: TextInputAction.next,
            inputType: TextInputType.streetAddress,
            func: (val) => ref
                .read(restaurantAddressProvider.notifier)
                .update((state) => val),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              hintText: text.restaurant_working_hours,
              icon: Icons.watch_later,
              obscure: false,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.text,
              func: (val) => ref
                  .read(restaurantHoursProvider.notifier)
                  .update((state) => val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              hintText: text.restaurant_website,
              icon: Icons.web,
              obscure: false,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.url,
              func: (val) => ref
                  .read(restaurantWebsiteProvider.notifier)
                  .update((state) => val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              hintText: text.restaurant_phone_number,
              icon: Icons.phone,
              obscure: false,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              func: (val) => ref
                  .read(restaurantPhoneNumberProvider.notifier)
                  .update((state) => val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              hintText: text.restaurant_descriptions,
              icon: Icons.note_alt_sharp,
              obscure: false,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.text,
              func: (val) => ref
                  .read(restaurantDescriptionProvider.notifier)
                  .update((state) => val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              hintText: text.restaurant_payment,
              icon: Icons.payment,
              obscure: false,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.text,
              func: (val) => ref
                  .read(restaurantPaymentProvider.notifier)
                  .update((state) => val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: CustomTextField(
              func: (value) => ref
                  .read(restaurantTablesProvider.notifier)
                  .update((state) => value),
              inputType: TextInputType.number,
              icon: Icons.table_bar,
              hintText: text.outside_tables,
              obscure: false,
              textInputAction: TextInputAction.next,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: _HeaderPictureButton(),
          ),
        ],
      ),
    );
  }
}
