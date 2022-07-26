import 'package:sqflite/sqflite.dart';
class userModel {
  final int? id;
  final String userName;
  final String apartmentNo;


  userModel({this.id, required this.userName, required this.apartmentNo});

  factory userModel.fromMap(Map<String, dynamic> json)  => new userModel(
       id: json['id'],
       userName: json['userName'],
       apartmentNo: json['apartmentNo']
   );
   Map<String,dynamic> toMap(){
     return {
       'id' : id,
       'userName' : userName,
       'apartmentNo' : apartmentNo,
     };
   }
}

