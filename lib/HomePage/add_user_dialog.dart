
import 'package:doorman_app/Constants.dart';
import 'package:doorman_app/HomePage/db_helper_for_user.dart';
import 'package:flutter/material.dart';

import 'userModel.dart';

class addUserDialog extends StatefulWidget {



  const addUserDialog({super.key});
  @override
  State<addUserDialog> createState() => _addUserDialogState();
}

class _addUserDialogState extends State<addUserDialog> {
final  formkey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {

    return Form(
      key: formkey,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 300,
        width: 400,
        child: Column(
          children: [
            Text(
              "Kullanıcı ekle",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildTextField("Kullanıcı adı giriniz", userNameController),
            _buildTextField("Daire no giriniz" ,apartmentNoController),
            ElevatedButton(
                onPressed: () async {
                  try{
                    print("burası boş mu");
                    print(userNameController.text.isEmpty);
                    print("doğru ise boş");
                    if(formkey.currentState!.validate()){
                      formkey.currentState!.save();
                      await databaseHelperForUser.instance.add(
                          userModel(userName: userNameController.text, apartmentNo: apartmentNoController.text)
                      );
                      Navigator.of(context).pop();
                      setState(() {
                        userNameController.clear();
                        apartmentNoController.clear();
                      });
                    }

                  }catch (SQLiteConstraintException) {
                    print("aynı apartman no kullanılmış");
                    showUserExceptionAlert();

                  }

            }, child: Text("ekle"))
          ],
        ),
      ),
    );
  }

  void showUserExceptionAlert(){
    showDialog(
      context: context,
      builder: (_){
        return AlertDialog(
          content: Container(
            height: 100,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 7,child: Text("Aynı apartman numarasına sahip başka bir kullanıcı mevcut.")),
                Expanded(
                  flex: 3,
                  child: TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("Geri")),
                ),
              ],
            ),
          ),
        );
      },

    );
  }


   _buildTextField(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(4),
        child: TextFormField(
          //key: _formkey,

          validator: (s){
            if(s == null || s.isEmpty){
              return "bu alan boş olamaz";
            }
            else return null;
          },
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
