class OrderItem {
  final String itemType;
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;
  final String itemImage;
  final bool available;

  OrderItem({
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
      );

  @override
  bool operator ==(Object other) =>
      other is OrderItem && itemTitle == other.itemTitle;

  @override
  int get hashCode => itemTitle.hashCode;
}
