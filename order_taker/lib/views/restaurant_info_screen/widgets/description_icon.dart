part of '../restaurant_info.dart';

class _DescriptionIcon extends ConsumerWidget {
  const _DescriptionIcon({
    required this.information,
    required this.infoIcon,
    required this.controllerProvider,
    required this.restaurantDetailsType,
    required this.restaurantTitle,
    required this.admin,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final String restaurantTitle;
  final String information;
  final IconData infoIcon;
  final RestaurantDetailsType restaurantDetailsType;
  final bool admin;
  final VoidCallback? onTap;
  final StateProviderFamily<TextEditingController, String> controllerProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(controllerProvider(information));
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
              width: 20,
            ),
            Consumer(
              builder: (context, ref, child) => Flexible(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onEditingComplete: () => ref
                      .read(restaurantInfoControllerProvider.notifier)
                      .submitRestaurantDetails(
                        ref,
                        restaurantDetailsType,
                        controller.value.text,
                        restaurantTitle,
                      ),
                  readOnly: !admin,
                  enabled: admin,
                  textInputAction: TextInputAction.done,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
