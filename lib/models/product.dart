class Product {
  late int id;
  late String name;
  late String info;
  late double price;
  late int quantity;
  late int userId;

  static const String tableName = 'products';

  Product();

  Product.fromMap(Map<String, dynamic> rawMap) {
    id = rawMap['id'];
    name = rawMap['name'];
    info = rawMap['info'];
    price = rawMap['price'];
    quantity = rawMap['quantity'];
    userId = rawMap['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['info'] = info;
    map['price'] = price;
    map['quantity'] = quantity;
    map['user_id'] = userId;
    return map;
  }
}
