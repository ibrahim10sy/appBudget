import 'package:flutter/material.dart';

class Depense extends StatelessWidget{
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
      
        Image.asset("images/aaa.png"),
          ), 
       
           Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: 
          
           Text("Suivez vos dépenses",  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
            ),
             ),
           Text("Suivez et analysez vos dépenses  ",
            style:TextStyle(fontSize: 20),
            ),
           
            Container(
              padding: const  EdgeInsets.only( bottom: 75),
              child:
           Text("immédiatement",
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
                Text("Suivant", 
                style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Color(0xFF2F9062), 
                ),
                ),
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