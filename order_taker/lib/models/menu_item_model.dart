import 'order_model.dart';

class OrderItem {
  final String itemType;
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;
  final String itemImage;

  OrderItem({
    required this.itemType,
    required this.itemTitle,
    required this.itemIngredients,
    required this.itemPrice,
    required this.itemImage,
  });

  Map<String, dynamic> orderItemToMap() => {
        'itemType': itemType,
        'itemTitle': itemTitle,
        'itemIngredients': itemIngredients,
        'itemPrice': '$itemPrice lv.',
        'itemImage': itemImage,
      };

  factory OrderItem.fromMap(Map data) => OrderItem(
        itemType: data['itemType'],
        itemTitle: data['itemTitle'],
        itemIngredients: data['itemIngredients'],
        itemPrice: data['itemPrice'],
        itemImage: data['itemImage'],
      );
}
