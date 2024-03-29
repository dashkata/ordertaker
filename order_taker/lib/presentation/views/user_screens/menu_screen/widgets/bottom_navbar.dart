part of '../menu.dart';

class SectionNavBar extends ConsumerWidget {
  const SectionNavBar({
    required this.reservation,
    Key? key,
  }) : super(key: key);
  final Reservation reservation;

  void _navBarFunction(int value, WidgetRef ref, BuildContext context) {
    ref.read(navBarIndexProvider.notifier).update((state) => value);
    switch (value) {
      case 0:
        ref
            .read(billScreenViewModelProvider.notifier)
            .navigateToMenu(reservation: reservation);
        break;
      case 1:
        ref.read(menuViewModelProvider.notifier).navigateToBill(reservation);
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      backgroundColor: mainColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.food_bank),
          label: text.appetizers,
          backgroundColor: mainColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.local_atm),
          label: text.check,
          backgroundColor: mainColor,
        ),
      ],
      selectedItemColor: accentBlackColor,
      currentIndex: ref.watch(navBarIndexProvider),
      onTap: (value) => _navBarFunction(value, ref, context),
    );
  }
}
