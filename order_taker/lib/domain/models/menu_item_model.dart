class OrderItem {
  final String itemType;
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;
  final String itemImage;
  final String itemCurrency;
  final bool available;

  OrderItem({
    required this.itemCurrency,
    required this.itemType,
    required this.itemTitle,
    required this.itemIngredients,
    required this.itemPrice,
    required this.itemImage,
    required this.available,
  });

  Map<String, dynamic> orderItemToMap() => {
        'itemType': itemType,
        'itemTitle': itemTitle,
        'itemIngredients': itemIngredients,
        'itemPrice': itemPrice,
        'itemCurrency': itemCurrency,
        'itemImage': itemImage,
        'available': available,
      };

  factory OrderItem.fromMap(Map data) => OrderItem(
        itemType: data['itemType'],
        itemTitle: data['itemTitle'],
        itemIngredients: data['itemIngredients'],
        itemPrice: data['itemPrice'],
        itemImage: data['itemImage'],
        available: data['available'],
        itemCurrency: data['itemCurrency'],
      );

  @override
  bool operator ==(Object other) =>
      other is OrderItem && itemTitle == other.itemTitle;

  @override
  int get hashCode => itemTitle.hashCode;
}
