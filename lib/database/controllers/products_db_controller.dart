import 'package:database_elancer/database/db_operations.dart';
import 'package:database_elancer/models/product.dart';

class ProductDbController extends DbOperations<Product> {
  // CRUD
  // Create, Read, Update, Delete
  @override
  Future<int> create(Product model) async {
    // int newRawId = await database.rawInsert(
    //     'INSERT INTO products (name,info, price, quantity,user_id) VALUES (?, ?, ?, ?, ?)',
    //     [model.name, model.info, model.price, model.quantity, model.userId]);

    return await database.insert(Product.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // int countDeletedRaw =
    //     await database.rawDelete('DELETE FROM products WHERE id=?', [id]);

    int countDeleteRaw = await database
        .delete(Product.tableName, where: 'id=?', whereArgs: [id]);
    return countDeleteRaw != 0;
  }

  @override
  Future<List<Product>> read() async {
    // List<Map<String, dynamic>> rowsMap =
    //     await database.query('SELECT * FROM product ');

    List<Map<String, dynamic>> rowsMap =
        await database.query(Product.tableName);
    return rowsMap.map((rawMap) => Product.fromMap(rawMap)).toList();
  }

  @override
  Future<Product?> show(int id) async {
    List<Map<String, dynamic>> rowsMap =
        await database.query(Product.tableName, where: 'id=?', whereArgs: [id]);
    return rowsMap.isNotEmpty ? Product.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Product model) async {
    // int updatedRow = await database.rawUpdate(
    //   'UPDATE products SET name =?, info=? ,price=?, quantity=? WHERE id=?, AND user_id =?',
    //   [
    //     model.name,
    //     model.info,
    //     model.price,
    //     model.quantity,
    //     model.id,
    //     model.userId
    //   ],
    // );

    int updatedRow = await database.update(Product.tableName, model.toMap(),
        where: 'id=?, AND user_id =?', whereArgs: [model.id, model.userId]);
    return updatedRow == 1;
  }
}
