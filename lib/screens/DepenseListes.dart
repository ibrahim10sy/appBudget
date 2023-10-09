import 'package:flutter/material.dart';

class DepensesListes extends StatefulWidget {
  const DepensesListes({super.key});

  @override
  _DepenseState createState() => _DepenseState();
}

class _DepenseState extends State<DepensesListes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 1, left: 15, right: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(31),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 7,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Stack(
                        children: [
                          Image.asset('assets/images/photoprofil.png',
                              fit: BoxFit.cover),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Pablo Picasso',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),


              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Container(                  
                    margin: EdgeInsets.only(
                        right: 10, left: 10, bottom: 10, top: 50),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(47, 144, 98, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Budget Total:',
                            style: TextStyle(
                                fontSize: 29.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 50),
                          OutlinedButton(
                            onPressed: () {
                              // Action à effectuer lorsqu'on appuie sur le bouton
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    90.0), // Ajustez la valeur selon vos besoins
                              ),
                              side: BorderSide(
                                  color: Colors.white), // Couleur de la bordure
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
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 40,
                    child: Image.asset(
                      'assets/images/wallet.png',
                      height: 90,
                      fit: BoxFit.contain,
                      // Utilisez BoxFit.contain si vous préférez que l'image soit entièrement contenue dans le conteneur
                    ),
                  )
                ],
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
                      children: [
                        const ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/wallet.png"),
                            ),
                            title: Text("Liste des depenses",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(47, 144, 98, 1),
                                ))),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            //physics: NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white10, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/wallet.png"),
                                    ),
                                    title: Text("Budget pour le loyer")),
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
        ),
      ),
    );
  }
}
