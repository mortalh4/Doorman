import 'package:doorman_app/Constants.dart';
import 'package:doorman_app/HomePage/userModel.dart';
import 'package:doorman_app/allExpenses/db_helper_for_expenses.dart';
import 'package:doorman_app/allExpenses/expenses_model.dart';
import 'package:doorman_app/allExpenses/payment/db_helper_for_payment.dart';
import 'package:doorman_app/allExpenses/payment/received_payment_model.dart';
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
  double sumOfPaymentValue = 0;
  String? girilenHarcama = "boş değer";
  double harcamamMiktari = 0;
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Son hafta"),value: "SonHafta"),
      DropdownMenuItem(child: Text("Son ay"),value: "SonAy"),
      DropdownMenuItem(child: Text("Son 3 ay"),value: "Son3Ay"),
      DropdownMenuItem(child: Text("Tüm"),value: "Tum"),
    ];
    return menuItems;
  }
  String selectedValue = "Tum";

  Future<double> toplamHesapla(int? id) async {
    final DateTime date = DateTime.now();
    int dateTomilliSecond = findCreatedTime(date);
    int oneWeek = dateTomilliSecond-604800000;  // one week has 604 800 000 millisecond. oneWeek variable is represents the date one week before from now
    int oneMonth = dateTomilliSecond-2629743830;// one month has 2 629 743 830  millisecond
    int threeMonths = dateTomilliSecond-7889231490;// three months have 7 889 231 490 millisecond
    int onehour = dateTomilliSecond-3600000;
    double totalSum = 0;
    switch (selectedValue){
      case "SonHafta"  : {
        totalSum= (await databasehelperForExpenses.instance.sumforSpecificTime(widget.user.id, onehour))[0]['total'];
      }
      break;
      case "SonAy" : {
        totalSum= (await databasehelperForExpenses.instance.sumforSpecificTime(widget.user.id, oneMonth))[0]['total'];
      }
      break;
      case "Son3Ay" : {
        totalSum= (await databasehelperForExpenses.instance.sumforSpecificTime(widget.user.id, threeMonths))[0]['total'];
      }
      break;
      default : {
        totalSum=   (await databasehelperForExpenses.instance
            .sum(widget.user.id))[0]['total'];
      }
      break;
    }


    if (totalSum > 0) {
      setState(() {
        toplamHarcama = totalSum;
      });
    }
    return totalSum;
    print("toplam harcamanın değeri gözüküyor mu");
    print(totalSum);
    print("toplam harcamanın değeri gözüküyor mu");
  }

  /*Future<int> baskaToplamHesapla(expensesModel e)async{
    double harcama= 0;

  }*/


  void sumOfPayments(int? id) async {
    final DateTime date = DateTime.now();
    int dateTomilliSecond = findCreatedTime(date);
    int oneWeek = dateTomilliSecond-604800000;  // one week has 604 800 000 millisecond. oneWeek variable is represents the date one week before from now
    int oneMonth = dateTomilliSecond-2629743830;// one month has 2 629 743 830  millisecond
    int threeMonths = dateTomilliSecond-7889231490;// three months have 7 889 231 490 millisecond
    double total = 0;
    switch (selectedValue){
      case "SonHafta"  : {
        total = (await databaseHelperForPayment.instance.sumForSpecificTime(widget.user.id, oneWeek))[0]['total'];
      }
      break;
      case "SonAy" : {
        total = (await databaseHelperForPayment.instance.sumForSpecificTime(widget.user.id, oneMonth))[0]['total'];
      }
      break;
      case "Son3Ay" : {
        total = (await databaseHelperForPayment.instance.sumForSpecificTime(widget.user.id, threeMonths))[0]['total'];
      }
      break;
      default : {
        total = (await databaseHelperForPayment.instance
            .sum(widget.user.id))[0]['total'];
      }
      break;
    }





    total = (await databaseHelperForPayment.instance.sum(widget.user.id))[0]['total'];
    if(total > 0){
      setState(() {
        sumOfPaymentValue = total;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //toplamHesapla(widget.user.id);
    sumOfPayments(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
          appBar: AppBar(

              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.user.userName,
                style: Constants.pageHeader,
              ),
              actions: [
                 DropdownButton(
                   value: selectedValue,items: dropdownItems, onChanged: (String? newValue){
                    setState(() {
                      selectedValue = newValue!;
                    });

                  },)


              ],
              backgroundColor: Constants.appColor,
              centerTitle: true),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //_buildForm(),
                Expanded(flex: 3, child: _buildForm()),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: Constants.cardPadding,
                            child: const Center(
                              child: Text(
                                "Toplam",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          //Text("$toplamHarcama"),
                          buildFutureBuilder()
                        ],
                      ),
                    )

                        //Text("$toplamHarcama" /*> 0? "$toplamHarcama":"0"*/,style: Constants.addedExpensesStyle,),

                        )),
              ],
            ),
            Expanded(
              flex: 6,
                child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder<List<expensesModel>>(

                future: filterForList(selectedValue),
                builder: (BuildContext context,
                    AsyncSnapshot<List<expensesModel>> snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot.hasData);
                    print(snapshot.data?.isEmpty);

                    return Center(
                      child: Text("yükleniyor"),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: Text("lütfen harcama ekleyin"),
                        )
                      : ListView(
                          children: snapshot.data!.map((e) {
                            return buildCenter(e);
                          }).toList(),
                        );
                },
              ),
            )),
                 Expanded(
                   flex: 1,
                   child: Container(
                     child:Row(
                     children: [
                       _buildFormForpayment()
                     ],
                   ),
                ),
                 )

          ]
              )
      ),
    );
  }

  FutureBuilder<double> buildFutureBuilder() {
    return FutureBuilder(future: toplamHesapla(widget.user.id),builder: ( context, snapshot){

                            if(!snapshot.hasData){
                              return  Text("yükleniyor");
                            }
                            return snapshot.data == null ? Text("0"): Text(snapshot.data.toString());
                        });
  }
  Future <List<expensesModel>> filterForList(String selectedValue){
    final DateTime date = DateTime.now();
    int dateTomilliSecond = findCreatedTime(date);
    int oneWeek = dateTomilliSecond-604800000;
    int oneMonth = dateTomilliSecond-26297438300;
    int threeMonth = dateTomilliSecond-78892314900;

    int onehour = dateTomilliSecond-3600000;


    switch(selectedValue){
      case "SonHafta" : {
        return databasehelperForExpenses.instance.getExpensesModelForSpecificTime(widget.user.id, onehour);
      }
      break;
      case "SonAy": {
        return databasehelperForExpenses.instance.getExpensesModelForSpecificTime(widget.user.id, oneMonth);
      }
      break;
      case "Son3Ay": {
        return databasehelperForExpenses.instance.getExpensesModelForSpecificTime(widget.user.id, threeMonth);
      }
      break;
      default : {
        return databasehelperForExpenses.instance
            .getExpensesModel(widget.user.id);
      }
    }
}

  Center buildCenter(expensesModel e) {
    //toplamHesapla(double.tryParse(e.harcamaMiktari)!);
    return Center(
      child: ListTile(
        trailing: IconButton(
            onPressed: () {
              setState(() {
                databasehelperForExpenses.instance.remove(e.harcamaId!);
              });
            },
            icon: Icon(
              Icons.delete,
              color: Constants.appColor,
            )),
        leading: Icon(
          Icons.money,
          color: Constants.appColor,
          size: 32,
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => shoppingListScreen(
                    expenses: e,
                  )));
        },
        title: Text(
          e.harcamaAdi,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(e.harcamaMiktari.toString()),
      ),
    );
  }

  _buildTextFormFieldforText(TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        border: Constants.outlineBorderforFORM,
        hintText: "Market",
        filled: true,
        fillColor: Constants.fillColor,
      ),
      autofocus: true,
      validator: (s) {
        if (s!.length <= 0) {
          return "bu alanı boş bırakmayınız";
        } else
          return null;
      },
      controller: controller,
    );
  }

  _buildTextFieldforDouble(TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        border: Constants.outlineBorderforFORM,
        labelText: "Tutar",
      ),
      keyboardType: TextInputType.number,
      validator: (s) {
        if (s!.length <= 0) {
          return "bu alanı boş bırakmayınız";
        } else
          return null;
      },
      controller: controller,
    );
  }
  _buildFormForpayment(){
    return Form(
      key: formKey2,
      child:
         Expanded(
           child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 2,child:Padding(padding:Constants.formPadding ,child:_buildTextFieldforDouble(payment)) ),
              Expanded(flex: 1,child: IconButton(onPressed: ()async{
                final DateTime date = DateTime.now();
                sumOfPayments(widget.user.id);
                print("ödeme");
                print(payment.text);
                print("ödeme");

                if (formKey2.currentState!.validate()) {
                  formKey2.currentState!.save();
                  await databaseHelperForPayment.instance.add(
                      receivedPaymentModel(payment: double.tryParse(payment.text)!,createdTime: findCreatedTime(date) ,id: widget.user.id));
                  setState(() {
                    payment.clear();
                  });
                }

              }
              ,icon:Constants.rightArrow, ),),
              Expanded(flex: 1, child:  Text("$sumOfPaymentValue"),)


            ],
        ),
         ),

    );
  }

  _buildForm() {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: Constants.firstElementPadding,
              child: _buildTextFormFieldforText(expensesName),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 9,
                    child: Padding(
                      child: _buildTextFieldforDouble(expensesValue),
                      padding: Constants.formPadding,
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: Constants.formPadding,
                    child: IconButton(
                      onPressed: () async {
                        toplamHesapla(widget.user.id);
                        print(toplamHarcama);
                        print("********************");
                        final DateTime date = DateTime.now();
                        print(selectedValue);
                        print(expensesValue.text);
                        print(expensesName.text);
                        print("********************");
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          await databasehelperForExpenses.instance.add(
                              expensesModel(
                                  harcamaAdi: expensesName.text,
                                  harcamaMiktari:
                                      double.tryParse(expensesValue.text)!,
                                  createdTime: findCreatedTime(date),
                                  id: widget.user.id));
                          setState(() {
                            expensesName.clear();
                            expensesValue.clear();
                          });
                        }
                      },
                      icon: Constants.rightArrow,
                      // color: Colors.teal,iconSize: 32
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ));
  }
  int findCreatedTime (DateTime date){
    int createdTime = date.millisecondsSinceEpoch;
    return createdTime;
  }

  var payment = TextEditingController();
  var expensesName = TextEditingController();
  var expensesValue = TextEditingController();
}

/*
 */
