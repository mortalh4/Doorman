
import 'package:doorman_app/HomePage/db_helper_for_user.dart';
import 'package:flutter/material.dart';

import 'userModel.dart';

class addUserDialog extends StatefulWidget {



  const addUserDialog({super.key});
  @override
  State<addUserDialog> createState() => _addUserDialogState();
}

class _addUserDialogState extends State<addUserDialog> {





  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      height: 300,
      width: 400,
      child: Column(
        children: [
          Text(
            "Kullanıcı ekle",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          buildTextField("Kullanıcı adı giriniz", userNameController),
          buildTextField("Daire no giriniz" ,apartmentNoController),
          ElevatedButton(onPressed: () async {
            await databaseHelperForUser.instance.add(
              userModel(userName: userNameController.text, apartmentNo: apartmentNoController.text)
            );
            setState(() {
              userNameController.clear();
              apartmentNoController.clear();
            });
          }, child: Text("ekle"))
        ],
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              )
            )
          ),
          controller: controller,
        ),
    );
  }
  var userNameController = TextEditingController();
  var apartmentNoController = TextEditingController();
}
