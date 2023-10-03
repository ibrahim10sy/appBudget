import 'dart:math';

import 'package:flutter/material.dart';

class Categorie extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
   children:[   Container(
      padding: const EdgeInsets.only(bottom: 24, top: 50, left: 25, right: 30),
      child: Row(
        children: [
           Container(
          padding: const EdgeInsets.only(right: 20),
          width: 80,
          height: 80,
       child: Image.asset("images/aaa.png"),
          ),
          Text("Pablo Picasso",
             style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),)
      ]),
   
     ),
   const SizedBox(height: 5),
     Container(
       child:
        Stack(children: [
          Container(
           child: Image(
            image:  AssetImage('images/ccc.png'),
      ),),
      Container(
        padding: const EdgeInsets.only(top: 60, left: 15),
         child: Text("Catégories", 
            style: TextStyle(fontSize: 40, color: Colors.white,)
            ,) ,), 
            Container(
              padding: const EdgeInsets.only(top: 190, left: 10),
              child:
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
                          " + Ajouter catégorie",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
           // Text("+ Ajouter catégorie",
           //  style: TextStyle(fontSize: 25, color: Colors.white) )
         )
      ]),
     ),

    const SizedBox(height: 5),

     Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
      height: 300,
    decoration:  BoxDecoration(
     border: Border.all( color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0, ),
       borderRadius: BorderRadius.circular(40),
    boxShadow: [
      BoxShadow(
         color: Colors.black12,
        blurRadius: 25.0,
       
        ),
    ],
  ),
      child:ListView(
        children: [
        Column(
         children: [
           Container(
            padding: const EdgeInsets.only(top: 0),
           alignment: Alignment.centerLeft,
          child: 
        Text("Liste Catégories", 
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color :Color(0xFF2F9062)),
        ),
        )],
        ),
        Container(
           padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      height: 60,
    decoration:  BoxDecoration(
     border: Border.all( color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0, ),
       borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
         color: Colors.white,
        blurRadius: 25.0,
       
        ),
    ],
  ),

      child: Row(
       children: [
         Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('images/888.png'),
          ),
         Container(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Transport',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),), 
          Container(
            padding: const EdgeInsets.only(left: 100),
            child: Icon(Icons.edit_sharp , color:Color(0xFF2F9062)
            ), ),
            Container(
              child: Icon(Icons.delete, color: Colors.red,),)
  ],),
        ),
        const SizedBox(height: 5),
        Container(
           padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      height: 60,
    decoration:  BoxDecoration(
     border: Border.all( color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0, ),
       borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
         color: Colors.white,
        blurRadius: 25.0,
       
        ),
    ],
  ),

      child: Row(
       children: [
         Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('images/888.png'),
          ),
         Container(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Transport',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),), 
          Container(
            padding: const EdgeInsets.only(left: 100),
            child: Icon(Icons.edit_sharp , color:Color(0xFF2F9062)
            ), ),
            Container(
              child: Icon(Icons.delete, color: Colors.red,),)
  ],),
        ),
        const SizedBox(height: 5,),
        Container(
           padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      height: 60,
    decoration:  BoxDecoration(
     border: Border.all( color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0, ),
       borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
         color: Colors.white,
        blurRadius: 25.0,
       
        ),
    ],
  ),

      child: Row(
       children: [
         Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('images/888.png'),
          ),
         Container(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Transport',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),), 
          Container(
            padding: const EdgeInsets.only(left: 100),
            child: Icon(Icons.edit_sharp , color:Color(0xFF2F9062)
            ), ),
            Container(
              child: Icon(Icons.delete, color: Colors.red,),)
  ],),
        ),
        const SizedBox(height: 5,),
        Container(
           padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      height: 60,
    decoration:  BoxDecoration(
     border: Border.all( color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0, ),
       borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
         color: Colors.white,
        blurRadius: 25.0,
       
        ),
    ],
  ),

      child: Row(
       children: [
         Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('images/888.png'),
          ),
         Container(
          padding: const EdgeInsets.only(left: 15),
          child: Text('Transport',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),), 
          Container(
            padding: const EdgeInsets.only(left: 100),
            child: Icon(Icons.edit_sharp , color:Color(0xFF2F9062)
            ), ),
            Container(
              child: Icon(Icons.delete, color: Colors.red,),)
  ],),
        )
      ],)
      
      
      ,)
    ])
     
    ),
    );
}
}