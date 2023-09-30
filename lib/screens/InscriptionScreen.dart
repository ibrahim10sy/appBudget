import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8ebed),
      
      body: SingleChildScrollView(
        //we are adding this so that we can scroll when KeyBoard PopsUp.
        
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height, // If you get any blur that is outoff the screen then try to decrease or increase this negative value.This is mainly bcz it adjusts as per the phone size.
          alignment: Alignment.topCenter,
          
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    child: Column(
                      
                      children: [
                        Stack(
                          //I added stack so that i can position it anywhere i want with the coordinates like left ,right,bottom.
                          children: <Widget>[
                            Positioned(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/images/login1-removebg.png",
                                ),
                              ),
                            ),
                          ],
                        ),

                      //The Username,Email,Password Input fields.
                       const SizedBox(height: 20),
                        Container(
                          padding:const EdgeInsets.all(10),
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


                            children: [

                              Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: const Text(
                                "Inscription",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFE4AF18), ),
                              )),

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
                                      hintText: "Nom",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.verified_user, color: Colors.grey),
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
                                      hintText: "Prenom",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.verified_user, color: Colors.grey),
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
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.email, color: Colors.grey),
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

                              // const SizedBox(height: 15),
                              //   Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 2, vertical: 5),
                              //     decoration: const BoxDecoration(
                              //         color: Color(0xfff5f8fd),
                              //         borderRadius:
                              //         BorderRadius.all(Radius.circular(20))),
                              //       child: TextFormField(
                              //       obscureText: true,
                              //       decoration: const InputDecoration(
                              //         hintText: "Repeter mot de passe",
                              //         border: InputBorder.none,
                              //         prefixIcon:
                              //             Icon(Icons.vpn_key, color: Colors.grey),
                              //       ),
                              //     ),
                              //   ),

                            ],

                          ),

                        )
                      ],
                    ),
                  ),
                 const SizedBox(height: 30),
                  //Raised Buttons of sigup will appear.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     ElevatedButton(
                      onPressed: () {
                        // Your button's onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 13,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
                        backgroundColor: Color(0xFF2F9062), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.white70),
                        ),
                      ),
                      child:const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                     const SizedBox(width: 5),
                      InkWell(        //We can use the GestureDetector as well.
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: const BoxDecoration(
                                color:  Color(0xfff5f8fd),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  //For creating like a card.
                                  BoxShadow(  
                                      color: Colors.black12,
                                      offset: Offset(0.0,
                                          18.0),
                                      blurRadius: 15.0),
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, -04.0),
                                      blurRadius: 10.0),
                                ]),
                            child: Row(
                              children: [
                               const Text(
                                  "Continuer avec",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2F9062),
                                      fontWeight: FontWeight.w700),
                                ),
                                Image.asset(
                                  "assets/images/google.png",
                                  height: 40,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                 const SizedBox(height: 25),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("J'ai dejà un compte?"),
                   const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Connexion()),
                        );
                      },
                      child: Container(
                        child:const Text("Se connecter",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF2F9062),
                                fontSize: 18)),
                      ),
                    )
                  ]),
                ],
              )),
        ),
      ),
    );
  }
}

