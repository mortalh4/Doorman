import 'package:flutter/material.dart';

class itemModel{
  final int? urunId;
  final String alinacakUrunAdi;
  final String urunAdedi;
  final int? harcamaId;

  itemModel({this.urunId, required this.alinacakUrunAdi, required this.urunAdedi, this.harcamaId});

  factory itemModel.fromMap(Map<String ,dynamic> json) => new itemModel(
      urunId: json['urunId'],
      alinacakUrunAdi: json['alinacakUrunAdi'],
      urunAdedi: json['urunAdedi'],
      harcamaId:  json['harcamaId']
  );
  Map <String , dynamic> toMap(){
    return{
      'urunId' : urunId,
      'alinacakUrunAdi' : alinacakUrunAdi,
      'urunAdedi' : urunAdedi,
      'harcamaId' : harcamaId
    };
  }
}