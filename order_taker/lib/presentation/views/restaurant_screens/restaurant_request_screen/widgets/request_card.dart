part of '../restaurant_request.dart';

class _RequestCard extends ConsumerWidget {
  const _RequestCard({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Card(
        elevation: 10,
        shape: Styles.buildRoundedBorder(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  '${text.client_name} - ${reservation.name}',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  '${text.reservation_date} - ${reservation.date}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(
                '${text.preferred_location} - '
                '${reservation.preferredLocation.toString()}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '${text.number_of_people} - ${reservation.numberOfPeople.toString()}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonOutlined(
                      buttonText: text.disapprove,
                      buttonFunc: () => ref
                          .read(restaurantRequestControllerProvider.notifier)
                          .requestStats(
                            RequestStatus.disapproved,
                            reservation,
                          ),
                    ),
                    CustomButton(
                      buttonText: text.approve,
                      buttonFunc: () async => await ref
                          .read(restaurantRequestControllerProvider.notifier)
                          .setTableDialog(
                        const _TableDialogTitle(),
                        const _TableDialogContent(),
                        [
                          _TableDialogActions(
                            reservation: reservation,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
