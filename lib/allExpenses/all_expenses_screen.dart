

import 'package:doorman_app/HomePage/userModel.dart';
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
            title: Text("Harcamalar"),
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
              child:expensesList.length > 0? Container(
                height: MediaQuery.of(context).size.height*0.60,
                child: ListView.builder(itemCount: expensesList.length,itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      margin: EdgeInsets.all(4),
                      child: ListTile(
                        title: Text(expensesList[index].harcamaAdi),
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Text(expensesList[index].harcamaMiktari.toString()),
                        ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => shoppingListScreen()));
                        },
                      ),
                    ),
                  );
                }
                )
              ): Container(
                child: Center(child: Text("Lütfen harcama ekleyin"),),
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
      toplamHarcama = toplamHarcama + element.harcamaMiktari;
    });
    return toplamHarcama;
  }
  _buildTextFormFieldforText(){
    return TextFormField(
      decoration: InputDecoration(

        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        hintText: "Market",
        filled: true,
        fillColor: Colors.teal.shade100
      ) ,

      autofocus: true,
      onSaved: (deger){
        setState(() {
          girilenHarcama = deger!;
          print(girilenHarcama);
        });
      },
      validator: (s){
        if(s!.length <=0){
          return "bu alanı boş bırakmayınız";
        }
        else return null;
      },
    );
  }
  _buildTextFieldforDouble(){
    return TextFormField(
      decoration: InputDecoration(

        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        labelText: "Tutar",
      ) ,
      keyboardType: TextInputType.number,
      onSaved: (deger){
        setState(() {
          harcamamMiktari = double.tryParse(deger!)!;
          print(harcamamMiktari);
        });
      },

      validator: (s){
        if(s!.length <=0){
          return "bu alanı boş bırakmayınız";
        }
        else return null;
      },
    );
  }

  _buildForm() {
    return Form(
      key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: _buildTextFormFieldforText(),),

            SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,

                  child:Padding(child:_buildTextFieldforDouble(),
                      padding: EdgeInsets.symmetric(horizontal: 8),
    )
                ),

                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8),
                    child: IconButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        var eklenecekHarcama = expensesModel(girilenHarcama!, harcamamMiktari);
                        expensesList.add(eklenecekHarcama);
                        toplamHesapla();
                        print(girilenHarcama);
                      }

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
}

/*
 */