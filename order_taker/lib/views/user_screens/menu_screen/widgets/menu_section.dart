part of '../menu.dart';

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.sectionKey,
    required this.sectionTitle,
    Key? key,
  }) : super(key: key);

  final GlobalKey sectionKey;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: PaddingManager.p6,
            key: sectionKey,
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
                child: Column(
                  children: [
                    // MenuCard(
                    //   orderItem: OrderItem(
                    //     itemTitle: 'Салата Моцарела с авокадо',
                    //     itemIngredients:
                    //         'Топка мцарела, белени домати, авокадо, рукола, балсамова редукция, сос песто',
                    //     itemPrice: '300gr: 10.49lv',
                    //     itemType: 'Appetizer',
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
