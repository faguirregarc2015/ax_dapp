import 'package:ae_dapp/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Returns anything!

    return MaterialApp(
          title: "AthleteX",
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.yellow[700],
              accentColor: Colors.black),
          home: HomePage(),
        );
  }
}
