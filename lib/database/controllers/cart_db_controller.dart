import 'package:database_elancer/database/db_operations.dart';
import 'package:database_elancer/models/cart.dart';
import 'package:database_elancer/models/product.dart';

class CartDbController extends DbOperations<Cart> {
  // CRUD
  // Create, Read, Update, Delete

  @override
  Future<int> create(Cart model) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Cart>> read() {
    throw UnimplementedError();
  }

  @override
  Future<Cart?> show(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cart model) {
    throw UnimplementedError();
  }
}
