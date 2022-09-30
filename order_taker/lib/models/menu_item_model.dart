class OrderItem {
  final String itemType;
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;

  OrderItem({
    required this.itemType,
    required this.itemTitle,
    required this.itemIngredients,
    required this.itemPrice,
  });

  Map<String, dynamic> orderItemToMap() =>
      {
        'itemType': itemType,
        'itemTitle': itemTitle,
        'itemIngredients': itemIngredients,
        'itemPrice': itemPrice,
      };

  factory OrderItem.fromMap(Map data) =>
      OrderItem(
        itemType: data['itemType'],
        itemTitle: data['itemTitle'],
        itemIngredients: data['itemIngredients'],
        itemPrice: data['itemPrice'],
      );
}
