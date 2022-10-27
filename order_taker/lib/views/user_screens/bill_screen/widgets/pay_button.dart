part of '../bill.dart';

class PayButton extends ConsumerWidget {
  const PayButton({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: CustomButton(
        buttonText: text.pay,
        buttonFunc: () =>
            ref.read(billScreenControllerProvider.notifier).pay(reservation),
      ),
    );
  }
}
