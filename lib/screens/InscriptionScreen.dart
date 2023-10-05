// import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/main.dart';
// import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';

import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';
import 'ListUtilisateur.dart';
import 'UtilisateurService.dart';
// import 'package:http/http.dart' as http;

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InscriptionState createState() => _InscriptionState();
}


class _InscriptionState extends State<Inscription> {
  // ignore: non_constant_identifier_names
  TextEditingController nom_controller= TextEditingController() ;
  // ignore: non_constant_identifier_names
  TextEditingController prenom_controller= TextEditingController() ;
  // ignore: non_constant_identifier_names
  TextEditingController username_controller= TextEditingController() ;
  // ignore: non_constant_identifier_names
  TextEditingController email_controller= TextEditingController() ;
  // ignore: non_constant_identifier_names
  TextEditingController motDepasse_controller= TextEditingController() ;
  TextEditingController RepmotDePasse_controller = TextEditingController() ;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs de texte avec des valeurs vides.
    username_controller.clear();
    nom_controller.clear();
    prenom_controller.clear();
    email_controller.clear();
    motDepasse_controller.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8ebed),
      
      body:
      SingleChildScrollView(

        //we are adding this so that we can scroll when KeyBoard PopsUp.
        
        child: Container(

          height: MediaQuery.of(context)
              .size
              .height, // If you get any blur that is out off the screen then try to decrease or increase this negative value.This is mainly bcz it adjusts as per the phone size.
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
                                  "assets/images/logo.png",
                                  height: 100,
                                ),
                              ),
                            ),
                          ],
                        ),

                      //The Username,Email,Password Input fields.
                      // const SizedBox(height: 20),
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
                              )
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
                                    // obscureText: true,
                                      controller: username_controller,
                                    decoration: const InputDecoration(
                                      hintText: "Username",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.verified_user, color: Color(0xFF2F9062),),
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
                                  // obscureText: true,
                                  controller: prenom_controller,
                                  decoration: const InputDecoration(
                                    hintText: "Prenom",
                                    border: InputBorder.none,
                                    prefixIcon:
                                    Icon(Icons.verified_user, color: Color(0xFF2F9062),),
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
                                    // obscureText: true,
                                      controller: nom_controller,
                                    decoration: const InputDecoration(
                                      hintText: "Nom",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.verified_user, color: const Color(0xFF2F9062),),
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
                                    // obscureText: true,
                                      controller: email_controller,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      prefixIcon:
                                          Icon(Icons.email, color: Color(0xFF2F9062),),
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
                                controller: motDepasse_controller,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Mot de passe",
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.vpn_key, color:  Color(0xFF2F9062),),
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
                                controller: RepmotDePasse_controller,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Repetermot de passe",
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.vpn_key, color:  Color(0xFF2F9062),),
                                ),
                              ),
                            ),


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
                      onPressed: () async {
                        final username = username_controller.text;
                      final nom = nom_controller.text;
                      final prenom = prenom_controller.text;
                      final email = email_controller.text;
                        final motDePasse = motDepasse_controller.text;
                        final RepmotDePasse = RepmotDePasse_controller.text;

                        if (motDePasse != RepmotDePasse) {

                          final  String errorMessage = "Mot de passe different ";
                          // Gérez le cas où l'email ou le mot de passe est vide.
                          showDialog(
                            context:  context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:  Center(child: Text('Erreur')),
                                content:  Text(errorMessage),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child:  Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                      try {
                          UtilisateurProvider utilisateurProvider = Provider.of<UtilisateurProvider>(context, listen: false);
                      final nouveauUtilisateur = await UtilisateurService.ajouterUtilisateur(
                        username: username,
                      nom: nom,
                      prenom: prenom,
                      email: email,
                      motDePasse: motDePasse,
                      );
                      utilisateurProvider.setUtilisateur(nouveauUtilisateur);

                      // Le nouvel utilisateur a été ajouté avec succès, vous pouvez gérer la réponse ici.
                      print('Utilisateur ajouté avec succès : ${nouveauUtilisateur.nom}');
                      nom_controller.clear();
                      username_controller.clear();
                      prenom_controller.clear();
                      email_controller.clear();
                      motDepasse_controller.clear();
                      RepmotDePasse_controller.clear();
                      } catch (e) {
                      // Une erreur s'est produite lors de l'ajout de l'utilisateur, vous pouvez gérer l'erreur ici.
                      //print('Erreur lors de l\'ajout de l\'utilisateur : $e');
                      final String errorMessage = e.toString();
                      showDialog(
                          context:  context,
                          builder: (BuildContext context) {
                          return AlertDialog(
                          title:  Center(child: Text('Erreur')),
                          content:  Text(errorMessage),
                          actions: <Widget>[
                          TextButton(
                          onPressed: () {
                          Navigator.of(context).pop();
                          },
                          child:  Text('OK'),
                          ),
                          ],
                          );});
                      }},
                      style: ElevatedButton.styleFrom(
                        elevation: 13,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
                        backgroundColor: const Color(0xFF2F9062), // Button color
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ListUtilisateur()),
                          );
                        },
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
                          MaterialPageRoute(builder: (context) => const Connexion()),
                        );
                      },
                      // ignore: avoid_unnecessary_containers
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

class MyAlertDialog extends StatelessWidget{
  final String title;
  final String content;
  final List<Widget> actions;
  const MyAlertDialog({super.key, required this.title,required this.content, this.actions=const[]});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        ),
        actions: actions,
        content: Text(content,
        
        ),
    );
  }

}