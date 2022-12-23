part of '../restaurant_request.dart';

class _TableDialogTitle extends StatelessWidget {
  const _TableDialogTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        text.set_table_for_reservation,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _TableDialogContent extends ConsumerWidget {
  const _TableDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return CustomTextField(
      hintText: text.table_number,
      icon: Icons.table_bar,
      obscure: false,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      func: (value) {
        if (value == '') {
          value = '0';
        }
        ref.read(tableProvider.notifier).update(
              (state) => int.parse(value),
            );
      },
    );
  }
}

class _TableDialogActions extends ConsumerWidget {
  const _TableDialogActions({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            buttonText: text.cancel,
            buttonFunc: () => Navigator.pop(context),
          ),
          CustomButton(
            buttonText: text.confirm,
            buttonFunc: ref.watch(tableProvider) == 0
                ? null
                : () async {
                    await ref
                        .read(restaurantRequestControllerProvider.notifier)
                        .requestStats(
                          RequestStatus.approved,
                          Reservation(
                            userId: reservation.userId,
                            name: reservation.name,
                            restaurant: reservation.restaurant,
                            date: reservation.date,
                            numberOfPeople: reservation.numberOfPeople,
                            preferredLocation: reservation.preferredLocation,
                            table: ref.watch(tableProvider),
                            approved: true,
                            currentReservation: false,
                          ),
                        );
                    navigatorKey.currentState!.pop();
                  },
          ),
        ],
      ),
    );
  }
}
