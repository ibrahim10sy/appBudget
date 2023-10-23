import 'package:flutter/material.dart';

class Depense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 45),
              child: Image.asset(
                "assets/images/depense.png",
                height: 210,
                width: 210,
              ),
            ),

            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text("Suivez vos dépenses",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
            ),
            Text(
              "Suivez et analysez vos dépenses  ",
              style: TextStyle(fontSize: 20),
            ),

            Container(
              padding: const EdgeInsets.only(bottom: 75),
              child: Text(
                "immédiatement",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 45),
                child: Image(image: AssetImage('assets/images/89.png'))),
            // --------------------- // Footer-------------------

            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Container(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 50),
                        child:
                            // Icon(Icons.navigate_before, color: Colors.green,
                            IconButton(
                                icon: Icon(Icons.navigate_before,
                                    color: Color(0xFF2F9062)),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          backgroundColor:
                              const Color(0xFF2F9062), // Button color
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
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.navigate_next,
                              color: Color(0xFF2F9062)),
                          onPressed: () {}),
                    ],
                  )), // La ligne Row contenant Le text suivant et l'icone suivant
            ), // Fin de la ligne

            ElevatedButton(
              onPressed: () {
                // Your button's onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
          ],
        ),
      ),
    );
  }
}
