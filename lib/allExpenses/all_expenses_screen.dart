

import 'package:doorman_app/Constants.dart';
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
  double toplamHarcama = 0;
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
            title: Text(widget.user.userName, style: Constants.pageHeader,),

            backgroundColor: Constants.appColor,
            centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //_buildForm(),
                Expanded(flex: 3,child: _buildForm()),
                Expanded(flex: 1,child: Center(child: showAddedExpenses(toplamGoster: toplamHarcama))),

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

   double toplamHesapla(double newValue){

     toplamHarcama = toplamHarcama + newValue;


    return toplamHarcama;
  }
  Center buildCenter(expensesModel e) {
    //toplamHesapla(double.tryParse(e.harcamaMiktari)!);
    return Center(
      child: ListTile(

        trailing: IconButton(onPressed: (){setState(() {
          databasehelperForExpenses.instance.remove(e.harcamaId!);
        });},icon: Icon(Icons.delete, color: Constants.appColor,)),
        leading: Icon(Icons.money,color: Constants.appColor, size: 32,),
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

        border: Constants.outlineBorderforFORM,
        hintText: "Market",
        filled: true,
        fillColor: Constants.fillColor,
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

        border: Constants.outlineBorderforFORM,
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
            Padding(padding: Constants.firstElementPadding,
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
                      padding: Constants.formPadding,
    )
                ),

                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:  Constants.formPadding,
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
                    }, icon: Constants.rightArrow,
                       // color: Colors.teal,iconSize: 32
                    ),
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