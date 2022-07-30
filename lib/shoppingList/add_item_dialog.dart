import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:doorman_app/shoppingList/db_helper_for_shoppingList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class addItemDialog extends StatefulWidget {
final expensesModel expenses;
  const addItemDialog({Key? key, required this.expenses}) : super(key: key);

  @override

  State<addItemDialog> createState() => _addItemDialogState();
}

class _addItemDialogState extends State<addItemDialog> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        height: 300,
        width: 400,
        child: Column(
          children: [
            Text("Alışveriş listesine malzeme ekle",
              style: TextStyle(fontWeight: FontWeight.bold),),


            _buildTextField("Alınacak malzemeyi giriniz", itemNameController),
            _buildTextField("Kaç adet/kilo alacağınızı giriniz", itemCountController),

            ElevatedButton(onPressed: ()async{
              if(formkey.currentState!.validate()){
                formkey.currentState!.save();
                print("******");
                print(itemNameController.text);
                print("******");
                await databaseHelperForShoppingList.instance.add(
                    itemModel(alinacakUrunAdi: itemNameController.text, urunAdedi: itemCountController.text,harcamaId: widget.expenses.harcamaId)
                );
                Navigator.of(context).pop();

                setState(() {
                  itemNameController.clear();
                  itemCountController.clear();
                });
              }
            }, child: Text("ekle"))
          ],
        ),
      ),
    );
  }
  var itemNameController = TextEditingController();
  var itemCountController = TextEditingController();

  _buildTextField(String hint, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(4),
      child: TextFormField(
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
}
