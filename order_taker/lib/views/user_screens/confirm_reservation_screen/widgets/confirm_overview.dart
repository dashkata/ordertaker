part of '../confirm_reservation.dart';

class _ConfirmOverview extends StatelessWidget {
  const _ConfirmOverview({
    Key? key,
    required this.restaurantPic,
    required this.reservationInfo,
    required this.text,
  }) : super(key: key);

  final AsyncValue restaurantPic;
  final ConfirmReservationArguments reservationInfo;
  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingManager.p9,
            child: restaurantPic.when(
              data: (picValue) => CircleAvatar(
                backgroundImage: NetworkImage(
                  picValue,
                ),
                radius: 45,
              ),
              error: (e, s) => ErrorAlertDialog(
                errorMessage: e.toString(),
              ),
              loading: CustomProgressIndicator.new,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reservationInfo.restaurantTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                    child: _DetailRow(
                      reservationInfo: reservationInfo,
                      text: text,
                    ),
                  ),
                  Text(
                    '${text.preferred_location}: ${reservationInfo.preferredLocation}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
