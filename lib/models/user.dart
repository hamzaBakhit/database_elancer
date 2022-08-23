class User {
  late int id;
  late String name;
  late String email;
  late String password;

  static const String tableName = 'users';

  User();

  /// Read row data from database table...
  User.fromMap(Map<String, dynamic> rawMap) {
    id = rawMap['id'];
    name = rawMap['name'];
    email = rawMap['email'];
  }

  /// Prepare map to be saved in database...
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = id;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
