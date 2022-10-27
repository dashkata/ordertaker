part of '../owner_restaurant_info.dart';

class _DescriptionIcon extends StatelessWidget {
  const _DescriptionIcon({
    required this.information,
    required this.infoIcon,
    Key? key,
  }) : super(key: key);
  final String information;
  final IconData infoIcon;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: Styles.buildBorderRadius(50),
                color: complementaryColor,
                boxShadow: const [
                  BoxShadow(blurRadius: 5),
                ],
              ),
              child: Icon(
                infoIcon,
                color: complementaryColor2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, ref, child) => ref.watch(editProvider)
                  ? TextField(
                      decoration: InputDecoration(
                        hintText: information,
                      ),
                    )
                  : Text(
                      information,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
            )
          ],
        ),
      );
}
