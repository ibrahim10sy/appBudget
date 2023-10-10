
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/AjoutDepense.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/DepenseListes.dart';
import 'package:ika_musaka/screens/ModifierBudget.dart';
import 'package:ika_musaka/screens/ModifierDepense.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/ProfilUtilisateur.dart';
import 'package:provider/provider.dart';
import 'model/utilisateur.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UtilisateurProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {  
    return const MaterialApp(
      // title: "LogIn Screen",
      debugShowCheckedModeBanner: false,
      // home: DepensesListes()
      // home: AjoutDepense()
      // home: ModifierDepense()
      home: ModifierBudget()
      );//Place SignUp function here to Observe SignUp Screen.
  }
  //AYA
}



 
