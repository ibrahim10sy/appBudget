import 'package:flutter/material.dart';

//Deuxième page

class Finances extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child:
         Image(
          image:  AssetImage('assets/images/finances.png' ),
          ), ),
          Container(
             padding: const EdgeInsets.only(bottom: 0),
            child:
          Text("Vos Finances en un seul",
           style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
           ),
           ),
           Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: 
          
           Text("endroit",  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
            ),
             ),
           Text("Obtenez une vue d'ensemble sur ",
            style:TextStyle(fontSize: 20),
            ),
            Container(
              padding: const  EdgeInsets.only( bottom: 75),
              child:
           Text("tout votre argent.",
            style:TextStyle(fontSize: 20) 
            ,),
            ),
      // --------------------- // Footer-------------------      

            Container(
              padding: const EdgeInsets.only( bottom: 25),
              child:
              Container( 
                padding:const EdgeInsets.only( right: 25),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
             ElevatedButton(onPressed: (){},  
              style: ElevatedButton.styleFrom(
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                          backgroundColor: const Color(0xFF2F9062), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.white70),
                          ),
                        ),
              child: const Text(
                          "Suivant",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),),
                // Text("Suivant", 
                // style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Color(0xFF2F9062), 
                // ),
                // ),
                Icon(Icons.navigate_next, color: Colors.green,)
               
              ],
            ) ),    // La ligne Row contenant Le text suivant et l'icone suivant 
            ) , // Fin de la ligne
           //    FlatButton(onPressed)
            ElevatedButton(
                        onPressed: () {
                          // Your button's onPressed logic here
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                          backgroundColor: const Color(0xFF2F9062), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.white70),
                          ),
                        ),
                        child: const Text(
                          "COMMENCER DES MAINTENANT",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),


           ],),
          

         
      ),
    );
  }
}