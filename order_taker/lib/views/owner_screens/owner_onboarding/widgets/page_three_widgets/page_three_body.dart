part of '../../onboarding.dart';

class _PageThreeBody extends ConsumerWidget {
  const _PageThreeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<MenuSection>> asyncMenu =
        ref.watch(fetchMenuProvider);
    return asyncMenu.when(
      data: (menu) => ListView.builder(
        shrinkWrap: true,
        itemCount: menu.length,
        itemBuilder: (_, index) => Column(
          children: List.generate(
            menu[index].items.length,
            (indexSelection) => Column(
              children: [
                Text(
                  menu[index].items[indexSelection].itemTitle,
                ),
                Text(
                  menu[index].items[indexSelection].itemPrice,
                ),
                Text(
                  menu[index].items[indexSelection].itemIngredients,
                )
              ],
            ),
          ),
        ),
      ),
      error: (e, s) => Text(
        e.toString(),
      ),
      loading: () => const LoadingIndicator(),
    );
  }
}
