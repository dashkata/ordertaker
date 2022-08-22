class OrderItem {
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;

  OrderItem({
    required this.itemTitle,
    required this.itemIngredients,
    required this.itemPrice,
  });
  Map<String, dynamic> orderItemToMap() {
    return {
      'itemTitle': itemTitle,
      'itemIngredients': itemIngredients,
      'itemPrice': itemPrice,
    };
  }
}
