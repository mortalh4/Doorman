import 'package:doorman_app/shoppingList/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_item_dialog.dart';

class shoppingListScreen extends StatefulWidget {
  const shoppingListScreen({Key? key}) : super(key: key);

  @override
  State<shoppingListScreen> createState() => _shoppingListScreenState();
}

class _shoppingListScreenState extends State<shoppingListScreen> {
  List<itemModel> itemList = [];

  @override
  Widget build(BuildContext context) {
    void addItemData(itemModel item) {
      setState(() {
        itemList.add(item);
      });
    }

    void showItemDialog() {
      print("tıklandı");
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: addItemDialog(addItem: addItemData),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showItemDialog,
          child: Icon(Icons.add),
          backgroundColor: Colors.teal,
        ),
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.teal,
          title: Text("Malzeme listesi"),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(4),
                child: ListTile(
                  title: Text(itemList[index].alinacakUrunAdi),
                  subtitle: Text(itemList[index].urunAdedi),
                ),
              );
            },
            itemCount: itemList.length,
          ),
        ),
      ),
    );
  }
}
