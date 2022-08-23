import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  DbController._();

  late Database _database;
  static DbController? _instance;

  factory DbController() {
    return _instance ??= DbController._();
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_db.sql');
    _database = await openDatabase(
      path,
      onOpen: (Database database) {},
      onCreate: (Database database, int version) async {
        // CREATE DATA BASE (USERS, PRODUCTS, CART) USING SQL...
        await database.execute('CREATE TABLE users('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'email TEXT NOT NULL,'
            'password TEXT NOT NULL'
            ')');

        await database.execute('CREATE TABLE product ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'info TEXT NOT NULL,'
            'price REAL NOT NULL,'
            'quantity INTEGER DEFAULT (0),'
            'user_id INTEGER,'
            'FOREIGN KEY (users_id) references users(id)'
            ')');

        await database.execute('CREATE TABLE cart('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'total REAL NOT NULL,'
            'count INTEGER NOT NULL,'
            'price NOT NULL,'
            'user_id INTEGER,'
            'product_id INTEGER,'
            'FOREIGN KEY (users_id) references users(id),'
            'FOREIGN KEY (product_id) references products (id)'
            ')');
      },
      onUpgrade: (Database database, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
