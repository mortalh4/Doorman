import 'dart:io';
import 'package:doorman_app/HomePage/userModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class databaseHelperForUser {
  databaseHelperForUser._privateConstructor();
  static final databaseHelperForUser instance = databaseHelperForUser._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();


  Future <Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }
  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userName TEXT,
    apartmentNo TEXT
    )
    ''');
  }

  Future <List<userModel>> getUserModel() async {
    Database db = await instance.database;
    var users = await db.query('users', orderBy: 'userName');
    List<userModel> userModelList = users.isNotEmpty ?
        users.map((e) => userModel.fromMap(e)).toList()
        : [];
    return userModelList;
  }

  Future<int> add(userModel user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }


}