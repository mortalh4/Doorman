import 'dart:io';

import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:doorman_app/shoppingList/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelperForShoppingList {
  databaseHelperForShoppingList._privateConstructor();
  static final databaseHelperForShoppingList instance = databaseHelperForShoppingList._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();
  Future <Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'shoppinglist.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE shoppinglist(
    urunId INTEGER PRIMARY KEY AUTOINCREMENT,
    alinacakUrunAdi TEXT,
    urunAdedi TEXT,
    harcamaId INTEGER,
    FOREIGN KEY(harcamaId) REFERENCES expenses(harcamaId)
    )
    ''');
  }

  Future <List<itemModel>> getItemModel() async {
    Database db = await instance.database;
    var items = await db.query('shoppinglist', orderBy: 'alinacakUrunAdi');
    List<itemModel> itemModelList = items.isNotEmpty ?
    items.map((e) => itemModel.fromMap(e)).toList()
        : [];
    return itemModelList;
  }

  Future<int> add(itemModel items) async {
    Database db = await instance.database;
    return await db.insert('shoppinglist', items.toMap());
  }

}