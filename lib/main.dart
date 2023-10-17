
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ika_musaka/provider/CategoriesProvider.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/AjoutDepense.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/Depense.dart';
import 'package:ika_musaka/screens/ProfilUtilisateur.dart';
import 'package:ika_musaka/services/depenseService.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
import 'package:ika_musaka/screens/accueil.dart';
import 'package:ika_musaka/screens/bottomNavigatorBar.dart';
import 'package:ika_musaka/services/BottomNavigationService.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(47, 144, 98, 1),
  ));
  runApp(
     MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context) => BottomNavigationService()),
         ChangeNotifierProvider(create: (context) => UtilisateurProvider()),
         ChangeNotifierProvider(create: (context) => BudgetService()),
         ChangeNotifierProvider(create: (context) => DepenseService()),
         ChangeNotifierProvider(create: (context) => CategoriesProvider())

       ],
       child:  const MyApp()),
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
    return  MaterialApp(
        routes: {
          '/profilUtilisateur': (context) => ProfilUtilisateur(),
          '/BottomNavigationPage':(context) => BottomNavigationPage(),
          // Autres routes...
        },
      // title: "LogIn Screen",
      debugShowCheckedModeBanner: false,
      // home: BottomNavigationPage(),
      home: const Connexion(),
    );//Place SignUp function here to Observe SignUp Screen.
  }
  //adama
}


