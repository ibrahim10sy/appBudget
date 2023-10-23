
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/Budget.dart';

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
              padding: const EdgeInsets.only(bottom: 45),
              child:
         Image(
          height: 210,
          width: 210,
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
              padding: const  EdgeInsets.only( bottom: 45),
              child:
           Text("tout votre argent.",
            style:TextStyle(fontSize: 20) 
            ,),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 45),
              child:Image(
                image: AssetImage('assets/images/ggg.png'))
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
             ElevatedButton(onPressed: (){
              Navigator.push(
                context, 
              MaterialPageRoute(builder: (context) =>  Budget()),
             );},  
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
               IconButton(icon:  Icon(Icons.navigate_next, color:Color(0xFF2F9062)),
                                       onPressed:()
                                       { Navigator.push(
                context, 
              MaterialPageRoute(builder: (context) =>  Budget()),
             );
               }
                ),
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
  // void navigateTo(){
  //   final route = MaterialPageRoute(
  //     builder: (context) => Budget(),
  //     );
  //     Navigator.push(context , route);
  // }
}