import 'package:flutter/material.dart';

void main() {
  runApp(const Notifatication());
}

class Notifatication extends StatefulWidget {
  const Notifatication({super.key});

  @override
  State<Notifatication> createState() => _NotifaticationState();
}

class _NotifaticationState extends State<Notifatication> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.blueAccent,
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // permet de supperposé les elements de la page en colonnes
          children: [
            Positioned(  // position de la barre

              child: Padding(padding: EdgeInsets.all(15),
                child:Container(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color:Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0,2)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(    // cercle profil
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/signin.png'),  // image
                      ),
                       //espace entre le proflil et le nom de l'utilisateur
                      Text(
                        'Saran Coulibaly',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),   // style attribuer au texte
                      ),

                      Icon(Icons.notifications, size: 40, color: Colors.amber),
                    ],
                  ),
                ),
              ),
            ),
            //contenanire en vert
            SizedBox(height: 50),
            Stack(

              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: 110,
                  decoration: BoxDecoration(
                    color: Color(0xFF2F9062),
                    border: Border.all(width: 2, color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, ),
                        child:
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.e, // Alignez les éléments à gauche
                          children: [
                            Text(
                              'Notifications',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left:50),// Ajustez cette valeur pour faire monter davantage l'icône
                                child: Align(
                                  alignment: Alignment(0.7, -7.3),
                                  child:  Icon(
                                    Icons.notifications,
                                    size: 90,
                                    color: Colors.amber,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
