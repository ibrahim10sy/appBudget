import 'package:flutter/material.dart';

class DepensesListes extends StatefulWidget{
  const DepensesListes({super.key});

  @override
  _DepenseState createState()=>_DepenseState();

}

class _DepenseState extends State<DepensesListes>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children:[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/photoprofil.png'),
                  ),
                  SizedBox(
                    width:16.0 ,
                  ),
                  Text("Name User",
                    style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.bold),
                  )
                ]
              ),
            ),
          ),
          // Container(
          //   height: 188,
          //   width: 380,
          //   decoration: BoxDecoration(
          //     color: Color.fromRGBO(47, 144, 98, 1),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Stack(
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Buget Total:',
          //                   style: TextStyle(fontSize: 29.0, fontWeight: FontWeight.bold, color: Colors.white),
          //                 ),
          //                 Spacer(),
          //                 Positioned(
          //                   top: -80,  // Ajustez la position verticale selon vos besoins
          //                   right: 0,  // Ajustez la position horizontale selon vos besoins
          //                   child: Image.asset(
          //                     'assets/images/wallet.png',
          //                     height: 50,
          //                     width: 50,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             SizedBox(height: 50),
          //             OutlinedButton(
          //               onPressed: () {
          //                 // Action à effectuer lorsqu'on appuie sur le bouton
          //               },
          //               style: OutlinedButton.styleFrom(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(90.0), // Ajustez la valeur selon vos besoins
          //                 ),
          //                 side: BorderSide(color: Colors.white), // Couleur de la bordure
          //               ),
          //               child: Text(
          //                 "+ Ajouter Dépenses",
          //                 style: TextStyle(
          //                   fontSize: 14.0,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // )
          Container(
            height: 188,
            width: 380,
            decoration: BoxDecoration(
              color: Color.fromRGBO(47, 144, 98, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Budget Total:',
                            style: TextStyle(fontSize: 29.0, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 50),
                      OutlinedButton(
                        onPressed: () {
                          // Action à effectuer lorsqu'on appuie sur le bouton
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0), // Ajustez la valeur selon vos besoins
                          ),
                          side: BorderSide(color: Colors.white), // Couleur de la bordure
                        ),
                        child: Text(
                          "+ Ajouter Dépenses",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    height: 100,  // Ajustez la hauteur de l'image selon vos besoins
                    width: 100,   // Ajustez la largeur de l'image selon vos besoins
                    child: Image.asset(
                      'assets/images/wallet.png',
                      fit: BoxFit.cover,
                    // Utilisez BoxFit.contain si vous préférez que l'image soit entièrement contenue dans le conteneur
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          Container(
            width: 372,
            height: 457,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/wallet.png"),
                        ),
                      title:Text("Liste des depenses",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(47, 144, 98, 1),))
                    ),

                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white10,width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const ListTile(

                                leading: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/wallet.png"),
                                ),
                                title:Text("Budget pour le loyer")
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}