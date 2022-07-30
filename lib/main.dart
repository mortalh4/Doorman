import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:doorman_app/OnBoarding%20Screen/build_page.dart';
import 'package:doorman_app/HomePage/home_page.dart';
import 'package:doorman_app/OnBoarding%20Screen/onboarding_screen.dart';
import 'package:doorman_app/shoppingList/shopping_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allExpenses/all_expenses_screen.dart';
int? initScreen;

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen =  await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home' : (context) => homePage(),
        'onboard': (context) => onboardingScreen(),
      },
    );
  }
}


    /*home: FutureBuilder<bool?>(
        future: checkLoginValue(),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {

          if (snapshot.data == false) {
            return onboardingScreen();
          } else {
            return homePage();
          }
        },
      ),*/















