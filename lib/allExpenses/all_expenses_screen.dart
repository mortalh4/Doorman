

import 'package:doorman_app/HomePage/userModel.dart';
import 'package:doorman_app/allExpenses/db_helper_for_expenses.dart';
import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:doorman_app/allExpenses/show_added_expenses.dart';
import 'package:doorman_app/shoppingList/shopping_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class allExpensesScreen extends StatefulWidget {
  final userModel user;
  const allExpensesScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<allExpensesScreen> createState() => _allExpensesScreenState();
}

class _allExpensesScreenState extends State<allExpensesScreen> {


  List<expensesModel> expensesList = [];
  String? girilenHarcama = "boş değer";
  double harcamamMiktari = 0;
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: (){
            Navigator.pop(context);
          },),
            title: Text(widget.user.userName),
            backgroundColor: Colors.teal,
            centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //_buildForm(),
                Expanded(flex: 3,child: _buildForm()),
                Expanded(flex: 1,child: Center(child: showAddedExpenses(toplamGoster: toplamHesapla()))),

              ],
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height*0.60,
                child: FutureBuilder<List<expensesModel>>(
                  future: databasehelperForExpenses.instance.getExpensesModel(),
                  builder: (BuildContext context, AsyncSnapshot<List<expensesModel>> snapshot){
                    if (!snapshot.hasData){
                      print(snapshot.hasData);
                      print(snapshot.data?.isEmpty);

                      return Center(child: Text("yükleniyor"),);
                    }
                    return snapshot.data!.isEmpty
                        ? Center(child: Text("lütfen harcama ekleyin"),): ListView(

                      children: snapshot.data!.map((e) {
                        return buildCenter(e);
                      }
                      ).toList(),
                    );



                  },
                ),
              )
              ),
              ]
            )

        ),
      );
  }

   double toplamHesapla(){
    double toplamHarcama = 0;

    expensesList.forEach((element) {
      double? value = double.tryParse(element.harcamaMiktari);
      toplamHarcama = toplamHarcama + value!;
    });
    return toplamHarcama;
  }
  Center buildCenter(expensesModel e) {
    return Center(
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> shoppingListScreen(expenses: e,)));
        },
        title: Text(e.harcamaAdi, style:  TextStyle(color: Colors.black),),
        subtitle: Text(e.harcamaMiktari.toString()),
      ),
    );
  }
  _buildTextFormFieldforText(TextEditingController controller){
    return TextFormField(
      decoration: InputDecoration(

        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        hintText: "Market",
        filled: true,
        fillColor: Colors.teal.shade100
      ) ,

      autofocus: true,

      validator: (s){
        if(s!.length <=0){
          return "bu alanı boş bırakmayınız";
        }
        else return null;
      },
      controller: controller,
    );
  }
  _buildTextFieldforDouble(TextEditingController controller){
    return TextFormField(
      decoration: InputDecoration(

        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        labelText: "Tutar",
      ) ,
      keyboardType: TextInputType.number,


      validator: (s){
        if(s!.length <=0){
          return "bu alanı boş bırakmayınız";
        }
        else return null;
      },
      controller: controller,
    );
  }

  _buildForm() {
    return Form(
      key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: _buildTextFormFieldforText(expensesName),),

            SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,

                  child:Padding(child:_buildTextFieldforDouble(expensesValue),
                      padding: EdgeInsets.symmetric(horizontal: 8),
    )
                ),

                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(onPressed: () async {
                      print("********************");


                      print(expensesValue.text );
                      print(expensesName.text );
                      print("********************");
                      await databasehelperForExpenses.instance.add(
                          expensesModel(harcamaAdi: expensesName.text, harcamaMiktari: expensesValue.text));
                      setState(() {
                        expensesName.clear();
                        expensesValue.clear();
                      });
                    }, icon: Icon(Icons.arrow_forward_ios_rounded),color: Colors.teal,iconSize: 32),
                  ),
                )

              ],
            ),
            SizedBox(height: 5,)
          ],
        )
    );
  }
  var expensesName = TextEditingController();
  var expensesValue = TextEditingController();
}

/*
 */