import 'package:flutter/material.dart';
class Damarrage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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



