
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/Depense.dart';

class Budget extends StatelessWidget{
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
          image:  AssetImage('assets/images/budget.png' ),
          ),
          ), 
         
           Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: 
          
           Text("Budgeter votre argent",  style:TextStyle(fontWeight: FontWeight.bold, fontSize: 25,)
            ),
             ),
           Text("Établissez de saines habitudes ",
            style:TextStyle(fontSize: 20),
            ),
            Container(
              padding: const  EdgeInsets.only( bottom: 0),
              child:
           Text("financières et contrôlez les",
            style:TextStyle(fontSize: 20) 
            ,),
            ),
            Container(
              padding: const  EdgeInsets.only( bottom: 75),
              child:
           Text("dépenses inutiles",
            style:TextStyle(fontSize: 20) 
            ,),
            ),
             Container(
              padding: EdgeInsets.only(bottom: 45),
              child:Image(
                image: AssetImage('assets/images/88.png'))
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
                Container(
                padding: EdgeInsets.only(right: 50),
                child:
                // Icon(Icons.navigate_before, color: Colors.green,
                IconButton(icon:  Icon(Icons.navigate_before, color:Color(0xFF2F9062)),
                                       onPressed:()
                                       { Navigator.pop(context);}
                ),
                ),
               ElevatedButton(onPressed: (){
                    Navigator.push(
                context, 
              MaterialPageRoute(builder: (context) =>  Depense()),
             );
               },  
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
              MaterialPageRoute(builder: (context) =>  Depense()),
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
}