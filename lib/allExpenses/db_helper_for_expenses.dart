import 'dart:io';
import 'package:doorman_app/HomePage/userModel.dart';
import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class databasehelperForExpenses{
  databasehelperForExpenses._privateConstructor();
  static final databasehelperForExpenses instance = databasehelperForExpenses._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();
  Future <Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses(
    harcamaId INTEGER PRIMARY KEY AUTOINCREMENT,
    harcamaAdi TEXT,
    harcamaMiktari REAL,
    createdTime INTEGER,
    id INTEGER,
    FOREIGN KEY(id) REFERENCES users(id)
    )
    ''');
  }

  Future <List<expensesModel>> getExpensesModel(int? id) async {
    Database db = await instance.database;
    var expenses = await db.query('expenses', orderBy: 'harcamaAdi', where: 'id = ?',
        whereArgs: [id] );
    print("helperdaki expenses tablosu");
    print(expenses);
    print("helperdaki expenses tablosu");
    List<expensesModel> expensesModelList = expenses.isNotEmpty ?
    expenses.map((e) => expensesModel.fromMap(e)).toList()
        : [];
    return expensesModelList;
  }Future <List<expensesModel>> getExpensesModelForSpecificTime(int? id, int? createdTime) async {
    Database db = await instance.database;
    var expenses = await db.rawQuery('SELECT * FROM expenses WHERE id = $id AND createdTime > $createdTime');
    print("helperdaki rangei olan expenses tablosu");
    print(expenses);
    print("helperdaki rangei olan expenses tablosu");
    List<expensesModel> expensesModelList = expenses.isNotEmpty ?
    expenses.map((e) => expensesModel.fromMap(e)).toList()
        : [];
    return expensesModelList;
  }

  Future<int> add(expensesModel expenses) async {
    Database db = await instance.database;
    return await db.insert('expenses', expenses.toMap());
  }
  Future<int> remove(int harcamaId)async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM expenses WHERE harcamaId = $harcamaId');
  }
  Future sum(int? id) async{
    Database db = await instance.database;
    var sum = await db.rawQuery('SELECT SUM(harcamaMiktari) as total FROM expenses WHERE id = $id'  );
    print("helperdaki sum");
    print(sum.toList());
    print("helperdaki sum");

    return sum;
  }Future sumforSpecificTime(int? id, int? createdTime) async{
    Database db = await instance.database;
    var sum = await db.rawQuery('SELECT SUM(harcamaMiktari) as total FROM expenses WHERE id = $id AND createdTime > $createdTime'  );
    print("helperdaki range belirtilmiş sum");
    print(sum.toList());
    print("helperdaki range belirtilmiş sum");
    return sum;
  }
}













