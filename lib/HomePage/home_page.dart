import 'package:doorman_app/Constants.dart';
import 'package:doorman_app/HomePage/db_helper_for_user.dart';
import 'package:doorman_app/HomePage/userModel.dart';
import 'package:doorman_app/HomePage/add_user_dialog.dart';
import 'package:doorman_app/allExpenses/all_expenses_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {




    void showUserDialog() {
      print("tıklandı");
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: addUserDialog(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          });
    }


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Constants.appColor),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: showUserDialog,
            child: Icon(Icons.add),
            backgroundColor: Constants.appColor),
        appBar: AppBar(

          backgroundColor: Constants.appColor,
          title: Center(child: Text('Home Page',style: Constants.pageHeader,)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: FutureBuilder<List<userModel>>(
            future: databaseHelperForUser.instance.getUserModel(),
            builder: (BuildContext context, AsyncSnapshot<List<userModel>> snapshot){
              if (!snapshot.hasData){
                print(snapshot.hasData);
                print(snapshot.data?.isEmpty);

                return Center(child: Text("yükleniyor"),);
              }
              return snapshot.data!.isEmpty
              ? Center(child: Text("Henüz kullanıcı eklemedin!"),):ListView(

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

  Center buildCenter(userModel e) {
    return Center(
                  child: ListTile(
                    trailing: IconButton(onPressed: (){
                      setState(() {
                        databaseHelperForUser.instance.remove(e.id!);
                      });
                    },
                    icon: Icon(Icons.delete),color: Constants.appColor,),
                    leading: CircleAvatar(
                      backgroundColor: Constants.appColor,
                      child: Icon(Icons.person),
                    ),

                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> allExpensesScreen(user: e)));
                    },
                    title: Text(e.userName),
                    subtitle: Text(e.apartmentNo),
                  ),
                );
  }
}
