import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// // import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/Categorie.dart';
// import 'package:ika_musaka/screens/Budget.dart';
// import 'package:ika_musaka/screens/ConnexionScreen.dart';
// import 'package:ika_musaka/screens/Depense.dart';
// import 'package:ika_musaka/screens/Finances.dart';
// import 'package:ika_musaka/screens/InscriptionScreen.dart';
// import 'package:ika_musaka/screens/demarrage.dart';

// import 'package:ika_musaka/provider/UtilisateurProvider.dart';
//  import 'package:ika_musaka/screens/AjouterBudget.dart';
// import 'package:ika_musaka/screens/ConnexionScreen.dart';
// import 'package:ika_musaka/screens/Notification.dart';
import 'package:ika_musaka/screens/ProfilUtilisateur.dart';
// import 'package:provider/provider.dart';
// import 'model/utilisateur.dart';

void main() {
  runApp(
      //  DevicePreview(
      // enabled: true,
      // builder: (context) =>
      const MyApp()); // Wrap your app
  // ) );
  //   ChangeNotifierProvider(
  //     create: (context) => UtilisateurProvider(),
  //     child: MyApp(),
  //   ),
  // );
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
    return MaterialApp(
      // routes: {
      theme: ThemeData(),
      // '/profilUtilisateur': (context) => ProfilUtilisateur(),
      // Autres routes...
      // },
      // title: "LogIn Screen",
      debugShowCheckedModeBanner: false,

      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      home: const Categorie(),
    ); //Place SignUp function here to Observe SignUp Screen.
  }
  //koureissi
}
