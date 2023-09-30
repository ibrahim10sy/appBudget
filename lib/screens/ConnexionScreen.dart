import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/InscriptionScreen.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
   // ignore: library_private_types_in_public_api
   _ConnexionState createState() => _ConnexionState();
}
class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8ebed),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              70, //For moving according to the screen when the keyboard popsup.
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 250,
                        width: 600,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          // child: Image.asset("assets/images/login1-removebg.png"),
                          child: Image.asset("assets/images/signin.png"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
// From here the login Credentials start.
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffe1e2e3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: const Text(
                                  "Connexion",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFE4AF18), ),
                                )),
                            ),
                          

                         const SizedBox(height: 5),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Color(0xfff5f8fd),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child:  TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color:  Colors.grey,
                                ),
                              ),
                            ),
                          ),


                         const SizedBox(height: 15),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Color(0xfff5f8fd),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Mot de passe",
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.vpn_key, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                        ]),
                  ),

                 const SizedBox(
                    height: 25,
                  ),

                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        child: const Text(
                      "Mot de passe oublié ?",
                      style:  TextStyle(
                          color: Color(0xFFE4AF18), 
                          fontWeight: FontWeight.w500),
                    )),
                  ),

                  const SizedBox(height: 25),
                  
                  //From here the signin buttons will occur.

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          "Connexion",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    const  SizedBox(width: 8),
                      GestureDetector(
                        //Signin with google button.
                        onTap: () {
                          //I changed it from raised button to container and then added gesture control to add an image of google.
                        },
                        child:  Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Color(0xfff5f8fd),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      //Created this shadow for looking elevated.
                                      //For creating like a card.
                                      color: Colors.black12,
                                      offset: Offset(0.0,
                                          18.0), // This offset is for making the the lenght of the shadow and also the brightness of the black color try seeing it by changing its values.
                                      blurRadius: 15.0),
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, -04.0),
                                      blurRadius: 10.0),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // I had added main axis allignment to be center to make to be at the center.
                              children: [
                               const Text(
                                  "Continuer avec",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2F9062), // Utilisez la couleur #2F9062
                                      fontWeight: FontWeight.w700),
                                ),
                                Image.asset(
                                  "assets/images/google.png",
                                  height: 40,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),

                 const SizedBox(height: 30),
                //Pour la navigation
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const  Text("Vous n'avez pas de compte?"),
                  const  SizedBox(width: 10),
                    MouseRegion(
                    cursor: SystemMouseCursors.click, // Définit le curseur en mode "pointer"
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inscription()),
                        );
                      },
                      child: Container(
                        child: const Text(
                          "S'inscrire maintenant",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2F9062), // Utilisez la couleur #2F9062
                          ),
                        ),
                      ),
                    ),
                  )

                  ]),
                   //fin la navigation


                ],
              )),
        ),
      ),
    );
  }
}
