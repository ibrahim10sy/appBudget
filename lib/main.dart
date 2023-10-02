import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/AjoutBudget.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/InscriptionScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // title: "LogIn Screen",
        debugShowCheckedModeBanner: false,
        home: Mapage()); //Place SignUp function here to Observe SignUp Screen.
  }
}
