import 'package:order_taker/domain/models/menu_item_model.dart';

class OrderItemEntity {
  final String itemType;
  final String itemTitle;
  final String itemIngredients;
  final String itemPrice;
  final String itemImage;
  final bool available;

  OrderItemEntity({
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

  factory OrderItemEntity.fromMap(Map data) => OrderItemEntity(
        itemType: data['itemType'],
        itemTitle: data['itemTitle'],
        itemIngredients: data['itemIngredients'],
        itemPrice: data['itemPrice'],
        itemImage: data['itemImage'],
        available: data['available'],
      );

  OrderItem toOrderItem() => OrderItem(
        itemType: itemType,
        itemTitle: itemTitle,
        itemIngredients: itemIngredients,
        itemPrice: itemPrice,
        itemImage: itemImage,
        available: available,
      );

  factory OrderItemEntity.fromOrderItem(OrderItem orderItem) => OrderItemEntity(
        itemType: orderItem.itemType,
        itemTitle: orderItem.itemTitle,
        itemIngredients: orderItem.itemIngredients,
        itemPrice: orderItem.itemPrice,
        itemImage: orderItem.itemImage,
        available: orderItem.available,
      );

  @override
  bool operator ==(Object other) =>
      other is OrderItemEntity && itemTitle == other.itemTitle;

  @override
  int get hashCode => itemTitle.hashCode;
}
