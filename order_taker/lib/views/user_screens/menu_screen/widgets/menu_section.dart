part of '../menu.dart';

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.sectionTitle,
    required this.menuList,
    Key? key,
  }) : super(key: key);

  final String sectionTitle;
  final List<OrderItem> menuList;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: PaddingManager.p6,
            child: Text(
              sectionTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: PaddingManager.p7,
            child: Material(
              borderRadius: Styles.buildBorderRadius(40),
              elevation: 10,
              child: Container(
                width: double.infinity,
                decoration: Styles.buildBoxDecoration(40, complementaryColor),
                child: ListView.builder(
                  itemCount: menuList.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => MenuCard(
                    orderItem: menuList[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
