import 'package:sqflite/sqflite.dart';
class expensesModel{
  final int? harcamaId;
  final String harcamaAdi;
  final String harcamaMiktari;

  expensesModel({this.harcamaId, required this.harcamaAdi, required this.harcamaMiktari});

  factory expensesModel.fromMap(Map <String , dynamic> json) => new expensesModel(
    harcamaId: json['harcamaId'],
    harcamaAdi: json['harcamaAdi'],
    harcamaMiktari: json['harcamaMiktari'],
  );

  Map<String , dynamic> toMap() {
    return{
      'harcamaId' : harcamaId,
      'harcamaAdi' : harcamaAdi,
      'harcamaMiktari' : harcamaMiktari,
    };
}
}