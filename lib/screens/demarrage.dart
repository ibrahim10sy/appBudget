import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Damarrage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: ListView(
        children: [
          Stack(children: [
            Container(
             //  width: 430,
               height: 1000,
             child: Center(
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                   FadeInImage.memoryNetwork(
                   placeholder: kTransparentImage,
                   image : 'assets/images/LOGO2 1.png',
                   width: 300,
                   height: 300,
                   fit: BoxFit.cover,
                  ),
                ],
              ),
              )
            ),
           
          ],)
      ]),
       )
    );
  }
}

//Deuxième page

