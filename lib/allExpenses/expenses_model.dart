import 'package:sqflite/sqflite.dart';
class expensesModel{
  final int? harcamaId;
  final String harcamaAdi;
  final double harcamaMiktari;
  final int createdTime;

  final int? id;

  expensesModel({this.harcamaId, required this.harcamaAdi, required this.harcamaMiktari, required this.createdTime,this.id});

  factory expensesModel.fromMap(Map <String , dynamic> json) => new expensesModel(
    harcamaId: json['harcamaId'],
    harcamaAdi: json['harcamaAdi'],
    harcamaMiktari: json['harcamaMiktari'],
    createdTime: json['createdTime'],
    id: json['id'],


  );

  Map<String , dynamic> toMap() {
    return{
      'harcamaId' : harcamaId,
      'harcamaAdi' : harcamaAdi,
      'harcamaMiktari' : harcamaMiktari,
      'createdTime' : createdTime,
      'id' : id,

    };
}
}