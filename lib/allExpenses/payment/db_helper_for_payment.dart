import 'dart:async';
import 'dart:io';
import 'package:doorman_app/HomePage/userModel.dart';
import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:doorman_app/allExpenses/payment/received_payment_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelperForPayment{
  databaseHelperForPayment._privateConstructor();
  static final databaseHelperForPayment instance = databaseHelperForPayment._privateConstructor();
  static Database? _database;


  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'payments.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
}

  Future _onCreate(Database db, int version)async {
    await db.execute('''
    CREATE TABLE payments(
    paymentId INTEGER PRIMARY KEY AUTOINCREMENT,
    payment REAL,
    createdTime INTEGER,
    id INTEGER,
    FOREIGN KEY(id) REFERENCES users(id)
    )
    ''');
  }

  Future <List<receivedPaymentModel>> getReceivedPaymentModel(int? id) async{
    Database db = await instance.database;
    var payments = await db.query('payments', orderBy: 'paymentId', where: 'id = ?',whereArgs: [id]);
    print("helperdaki payment");
    print(payments);
    print("helperdaki payment");

    List<receivedPaymentModel> receivedPaymentList = payments.isNotEmpty ?
        payments.map((e) => receivedPaymentModel.fromMap(e)).toList() : [];
    return receivedPaymentList;
  }

  Future <int> add(receivedPaymentModel payments) async {
    Database db = await instance.database;
    return await db.insert('payments', payments.toMap());
  }
  Future sum(int? id) async{
    Database db = await instance.database;
    var sum = await db.rawQuery('SELECT SUM(payment) as total FROM payments WHERE id = $id');
    print("payment helperdaki sum");
    print(sum);
    print("payment helperdaki sum");
    return sum;
  }Future sumForSpecificTime(int? id, int? createdTime) async{
    Database db = await instance.database;
    var sum = await db.rawQuery('SELECT SUM(payment) as total FROM payments WHERE id = $id AND createdTime > $createdTime');
    print("payment range helperdaki sum");
    print(sum);
    print("payment range  helperdaki sum");
    return sum;
  }
}

