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
            (indexSelection) => MenuCard(
              orderItem: menu[index].items[indexSelection],
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
