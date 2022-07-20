import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doorman_app/build_page.dart';
import 'package:doorman_app/home_page.dart';
import 'package:doorman_app/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  Future<bool?>? checkLoginValue() async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    bool? alreadyVisited = loginCheck.getBool("alreadyVisited");
    return alreadyVisited;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool?>(
        future: checkLoginValue(),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          print(snapshot.data);
          if (snapshot.data == false) {
            return onboardingScreen();
          } else {
            return homePage();
          }
        },
      ),
    );
   }
  }














routeLogin() async {
  print("already visited");
  bool visitingFlag = await getvisitingFlag();
  visitingFlag =  getvisitingFlag();
  print(visitingFlag);
  print(visitingFlag==false);
  if (visitingFlag == false){
    setVisitingFlag();
    return onboardingScreen();
  }
  else{
    return homePage();
  }
}
  setVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("alreadyVisited", true);
  }
  getvisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
    return alreadyVisited;
  }

