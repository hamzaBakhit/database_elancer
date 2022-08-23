import 'package:database_elancer/models/product.dart';

class Cart {
  late int id;
  late double total;
  late double price;
  late int count;
  late int userId;
  late int productId;

  static const String tableName = 'cart';

  Cart();

  Cart.fromMap(Map<String, dynamic> rawMap) {
    id = rawMap['id'];
    total = rawMap['total'];
    price = rawMap['price'];
    count = rawMap['count'];
    userId = rawMap['user_id'];
    productId = rawMap['product_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['price'] = price;
    map['count'] = count;
    map['user_id'] = userId;
    map['product_id'] = productId;
    return map;
  }
}
