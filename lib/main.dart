import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doorman_app/OnBoarding%20Screen/build_page.dart';
import 'package:doorman_app/HomePage/home_page.dart';
import 'package:doorman_app/OnBoarding%20Screen/onboarding_screen.dart';
import 'package:doorman_app/shoppingList/shopping_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allExpenses/all_expenses_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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














