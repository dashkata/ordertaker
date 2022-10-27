part of '../owner_restaurant_info.dart';

class _MenuSection extends ConsumerWidget {
  const _MenuSection({
    required this.restaurant,
    required this.admin,
    Key? key,
  }) : super(key: key);
  final Restaurant restaurant;
  final bool admin;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Menu',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              ref.watch(menuProvider(restaurant.title)).when(
                    data: (menu) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: menu.length,
                      itemBuilder: (_, index) => Column(
                        children: List.generate(
                          menu[index].items.length,
                          (indexSelection) => MenuCard(
                            orderItem: menu[index].items[indexSelection],
                          ),
                        ),
                      ),
                    ),
                    error: (e, s) => ErrorAlertDialog(
                      errorMessage: e.toString(),
                    ),
                    loading: () => const CustomProgressIndicator(),
                  ),
              if (admin) const AddMenuButton(),
            ],
          ),
        ),
      );
}
