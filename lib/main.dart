
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';

    
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
      home: Connexion()
      );//Place SignUp function here to Observe SignUp Screen.
  }
  //JJDJD
}


 
