part of '../restaurant_request.dart';

class _RequestCard extends ConsumerWidget {
  const _RequestCard({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
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
                    'Client name - ${reservation.name}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Reservation date - ${reservation.date}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Text(
                  'Preferred location - '
                  '${reservation.preferredLocation.toString()}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Number of people - ${reservation.numberOfPeople.toString()}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButtonOutlined(
                        buttonText: 'Disapprove',
                        buttonFunc: () => ref
                            .read(restaurantRequestControllerProvider.notifier)
                            .requestStats(
                              RequestStatus.disapproved,
                              reservation,
                            ),
                      ),
                      CustomButton(
                        buttonText: 'Approve',
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
