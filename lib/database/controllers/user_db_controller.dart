import 'dart:io';

import 'package:database_elancer/database/db_controller.dart';
import 'package:database_elancer/models/proccess_responce.dart';
import 'package:database_elancer/models/user.dart';
import 'package:database_elancer/prefs/shared_pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController {
  // login, register

  final Database _database = DbController().database;

  Future<ProcessResponse> login({
    required String email,
    required String password,
  }) async {
    List<Map<String, dynamic>> rowsMap = await _database.query(
      User.tableName,
      where: 'email =? AND password =?',
      whereArgs: [email, password],
    );

    if(rowsMap.isNotEmpty){
      User user = User.fromMap(rowsMap.first);
      SharedPrefController().save(user: user);
      return ProcessResponse(message: 'Logged in successfully',success: true);
    }
    return ProcessResponse(message: 'Credentials error, check and try again!',success: true);
  }

  Future<ProcessResponse> register({required User user}) async {
    // FIRST : RAW INSERT
    // int rawId = await _database.rawInsert(
    //     'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
    //     [user.name, user.email, user.password]);
    // SECOND : INSERT

    if (await _isEmailExist(email: user.email)) {
      int newRawId = await _database.insert(User.tableName, user.toMap());
      return ProcessResponse(
        message: newRawId != 0 ? 'Registered success' : 'Registered failed',
        success: newRawId != 0,
      );
    } else {
      return ProcessResponse(
          message: 'Email exist, use another', success: false);
    }
  }

  Future<bool> _isEmailExist({required String email}) async {
    List<Map<String, dynamic>> rawMap =
        await _database.rawQuery('SELECT * FROM users WHERE email=?', [email]);
    return rawMap.isEmpty;
  }

/**
 * SQL:
 *     1) Create => INSERT SQL
 *         => INSERT INTO tableName (c1, c2, c3) VALUES (v1, v2, v3)
 *     2) Read => SELECT SQL
 *         => SELECT * FROM tableName
 *         => SELECT * FROM tableName WHERE c1 = v1
 *         => SELECT * FROM tableName WHERE c1 = v1 AND c1 = v1
 *         => SELECT * FROM tableName WHERE c1 = v1 OR c1 = v1
 *
 *     3) UPDATE => UPDATE SQL
 *         => UPDATE tableName SET c1 = v1
 *         => UPDATE tableName SET c1 = v1 WHERE c1 = v1
 *         => UPDATE tableName SET c1 = v1, C2 = V2, C3 = C3 WHERE c1 = v1
 *
 *     4) DELETE > DELETE SQL
 *         => delete FROM tableName
 *         => delete FROM tableName WHERE c1 = v1
 *      -----------------
 *     *) DROP => DROP TABLE tableName
 *     *) ALTER
 *            => ADD COLUMN: ALTER TABLE tableName ADD tableName VARCHAR(45) NOT NULL AFTER (id)
 *
 *     ------------------
 *     *) ADD FOREIGN KEY (user_id) REFERENCES users(id) onDelete CASCADE - NULL - RESTRICT
 */
}
