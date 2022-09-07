class OrderItem {
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;

  OrderItem({
    required this.itemTitle,
    required this.itemIngredients,
    required this.itemPrice,
  });

  Map<String, dynamic> orderItemToMap() => {
        'itemTitle': itemTitle,
        'itemIngredients': itemIngredients,
        'itemPrice': itemPrice,
      };

  factory OrderItem.fromMap(Map data) => OrderItem(
        itemTitle: data['itemTitle'],
        itemIngredients: data['itemIngredients'],
        itemPrice: data['itemPrice'],
      );
}
