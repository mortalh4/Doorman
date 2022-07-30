import 'package:doorman_app/shoppingList/db_helper_for_shoppingList.dart';
import 'package:doorman_app/shoppingList/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../allExpenses/expenses_model.dart';
import 'add_item_dialog.dart';

class shoppingListScreen extends StatefulWidget {
  final expensesModel expenses;
  const shoppingListScreen({Key? key, required this.expenses}) : super(key: key);

  @override
  State<shoppingListScreen> createState() => _shoppingListScreenState();
}

class _shoppingListScreenState extends State<shoppingListScreen> {


  @override
  Widget build(BuildContext context) {

    void showItemDialog() {
      print("tıklandı");
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: addItemDialog(expenses: widget.expenses,),
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
          title: Text(widget.expenses.harcamaAdi),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: FutureBuilder<List<itemModel>>(
            future: databaseHelperForShoppingList.instance.getItemModel(widget.expenses.harcamaId),
            builder: (BuildContext context, AsyncSnapshot<List<itemModel>> snapshot){
              if (!snapshot.hasData){
                print(snapshot.hasData);
                print(snapshot.data?.isEmpty);

                return Center(child: Text("yükleniyor"),);
              }
              return snapshot.data!.isEmpty
                  ? Center(child: Text("Henüz malzeme eklemedin"),):ListView(

                children: snapshot.data!.map((e) {
                  return buildCenter(e);
                }
                ).toList(),
              );



            },
          ),
        ),
      ),
    );
  }
  Center buildCenter(itemModel e) {
    return Center(
      child: ListTile(
          trailing: IconButton(onPressed: (){setState(() {
            databaseHelperForShoppingList.instance.remove(e.urunId!);
          });},icon: Icon(Icons.delete, color: Constants.appColor,)),
        title: Text(e.alinacakUrunAdi),
        subtitle: Text(e.urunAdedi),
      ),
    );
  }
}







