import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/Budget.dart';
import 'package:ika_musaka/screens/Categorie.dart';
import 'package:ika_musaka/screens/Depense.dart';
import 'package:ika_musaka/screens/Finances.dart';
class Damarrage extends StatelessWidget{

   

  @override
  Widget build(BuildContext context) {


      Timer(
     const  Duration(seconds:5), 
      () =>
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
      builder: (_) =>  Categorie(),),),
     );

    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Image(
          image:  AssetImage('assets/images/LOGO2 1.png' ),
          ),
         Text("MUSAKA",
         style: TextStyle(fontSize: 30,  color: Color(0xFF2F9062),),)
       ],)
      ),
    );
  }
}



