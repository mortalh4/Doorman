import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class addItemDialog extends StatefulWidget {
  final Function(itemModel) addItem;
  const addItemDialog({Key? key, required this.addItem}) : super(key: key);

  @override

  State<addItemDialog> createState() => _addItemDialogState();
}

class _addItemDialogState extends State<addItemDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 400,
      child: Column(
        children: [
          Text("Alışveriş listesine malzeme ekle",
            style: TextStyle(fontWeight: FontWeight.bold),),
          buildTextField("Alınacak malzemeyi giriniz", itemNameController),
          buildTextField("Kaç adet/kilo alacağınızı giriniz", itemCountController),
          ElevatedButton(onPressed: (){
            final item = itemModel(itemNameController.text,itemCountController.text);
            widget.addItem(item);
          }, child: Text("ekle"))
        ],
      ),
    );
  }
  var itemNameController = TextEditingController();
  var itemCountController = TextEditingController();

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
}
