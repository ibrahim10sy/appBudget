import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/accueil.dart';
import 'package:ika_musaka/screens/bottomNavigatorBar.dart';
import 'package:ika_musaka/services/BottomNavigationService.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(
     MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context) => BottomNavigationService()),
         ChangeNotifierProvider(create: (context) => BudgetService())
       ],
       child:  MyApp()),
     );
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
      home: BottomNavigationPage(),
    );//Place SignUp function here to Observe SignUp Screen.
  }
  //adama
}


  /*
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationService(),
      child: const MaterialApp(
        // title: "LogIn Screen",
          debugShowCheckedModeBanner: false,
          home: BottomNavigationPage()
      )
    );//Place SignUp function here to Observe SignUp Screen.
  }
  */
