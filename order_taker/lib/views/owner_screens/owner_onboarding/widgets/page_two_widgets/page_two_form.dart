part of '../../onboarding.dart';

class _PageTwoForm extends StatelessWidget {
  const _PageTwoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Form(
      child: Column(
        children: [
          TextFields(
            hintText: text.restaurant_address,
            icon: Icons.location_city,
            obscure: false,
            inputType: TextInputType.streetAddress,
            func: (val) {},
          ),
          TextFields(
            hintText: text.restaurant_working_hours,
            icon: Icons.watch_later,
            obscure: false,
            inputType: TextInputType.none,
            func: (val) {},
          ),
          TextFields(
            hintText: text.restaurant_address,
            icon: Icons.web,
            obscure: false,
            inputType: TextInputType.streetAddress,
            func: (val) {},
          ),
          TextFields(
            hintText: text.restaurant_phone_number,
            icon: Icons.phone,
            obscure: false,
            inputType: TextInputType.phone,
            func: (val) {},
          )
        ],
      ),
    );
  }
}
