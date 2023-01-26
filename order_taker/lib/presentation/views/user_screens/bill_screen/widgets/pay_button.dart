part of '../bill.dart';

class PayButton extends ConsumerWidget {
  const PayButton({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewMessage = ref.watch(reviewMessageProvider);
    final reviewRating = ref.watch(reviewRatingProvider);
    final text = AppLocalizations.of(context)!;
    return SizedBox(
      width: 150,
      child: CustomButton(
        buttonText: text.pay,
        buttonFunc: () => ref.read(billScreenViewModelProvider.notifier).pay(
              reservation,
              reviewMessage,
              reviewRating,
            ),
      ),
    );
  }
}
