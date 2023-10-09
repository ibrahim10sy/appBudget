// import 'dart:convert';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/ConnexionScreen.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:path/path.dart';
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
 TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController motDepasse_controller = TextEditingController();
  TextEditingController RepmotDePasse_controller = TextEditingController();
  String? imageSrc;
  File? image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<void> _pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imagePermanent = await saveImagePermanently(image.path);

      setState(() {
        this.image = imagePermanent;
     
        imageSrc = imagePermanent.path; // Notez l'utilisation de "?"
      });
    } else {
      // L'utilisateur a annulé la sélection d'image.
      return;
    }
  } on PlatformException catch (e) {
    debugPrint('erreur : $e');
  }
}

  @override
  void initState() {
    super.initState();
    nom_controller.clear();
    prenom_controller.clear();
    email_controller.clear();
    motDepasse_controller.clear();
  }

  Future<void> _ajouterUtilisateur() async {
    // final photos = image;
    final nom = nom_controller.text;
    final prenom = prenom_controller.text;
    final email = email_controller.text;
    final motDePasse = motDepasse_controller.text;

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty || motDePasse.isEmpty) {
      // Gérez le cas où l'email ou le mot de passe est vide.
      const String errorMessage = "Veuillez remplir tous les champs";
      debugPrint(errorMessage);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Center(child: Text('Message')),
      //       content: const Text(errorMessage),
      //       actions: <Widget>[
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
      return;
    }

    try {
      final Utilisateur nouveauUtilisateur = await UtilisateurService.ajouterUtilisateur(
        nom: nom,
        prenom: prenom,
        email: email,
        motDePasse: motDePasse, photos: image as File,
        //  photos: photos as File,FileUploadInputElement
        // // photos: photos as File,
        
      );
      nouveauUtilisateur;
      // Le nouvel utilisateur a été ajouté avec succès, vous pouvez gérer la réponse ici.
      print('Utilisateur ajouté avec succès : ${nouveauUtilisateur.nom}');
      nom_controller.clear();
      prenom_controller.clear();
      email_controller.clear();
      motDepasse_controller.clear();
      RepmotDePasse_controller.clear();
    } catch (e) {
      // Une erreur s'est produite lors de l'ajout de l'utilisateur, vous pouvez gérer l'erreur ici.
      final String errorMessage = e.toString();
      debugPrint(errorMessage);
     
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      
      body:
      Container(

            padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context)
            .size
            .height, // If you get any blur that is out off the screen then try to decrease or increase this negative value.This is mainly bcz it adjusts as per the phone size.
        alignment: Alignment.topCenter,
        
        child: SingleChildScrollView(
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const  SizedBox(width: 70),
              Form(
                child: Column(
                  
                  children: [
                    Stack(
                      //I added stack so that i can position it anywhere i want with the coordinates like left ,right,bottom.
                      children: <Widget>[
        
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: (image !=null) ? Image.file(image!,
                             height: 150,
                            //  width: 400,
                             ):
                            Image.asset(
                              "assets/images/sign.png",
                              
                            ),
                          ),
                        ),
                      ],
                    ),
        
                  //The Username,Email,Password Input fields.
                  // const SizedBox(height: 20),
                  //Pour la navigation
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // const  Text("Vous n'avez pas de compte?"),
               MouseRegion(
                cursor: SystemMouseCursors.click, // Définit le curseur en mode "pointer"
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Connexion()),
                    );
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      "Connexion",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Color.fromARGB(255, 27, 30, 29),// Utilisez la couleur #2F9062
                      ),
                    ),
                  ),
                ),
              ),
              const  SizedBox(width: 70),
                MouseRegion(
                cursor: SystemMouseCursors.click, // Définit le curseur en mode "pointer"
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>const Inscription()),
                    );
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(
                      "Inscription",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: Color(0xFF2F9062), // Utilisez la couleur #2F9062
                      ),
                    ),
                  ),
                ),
              )
        
              ]),
              const SizedBox(height: 10),
                    Container(
        
                      padding:const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          ),
                      child: Column(
        
                        children: [
        
                          const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              decoration: const BoxDecoration(
                                  // color: Color(0xfff5f8fd),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                                child: 
                              
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                                backgroundColor: const Color(0xFF2ffffff), // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(color:  Color(0xFF2F9062)),
                                ),
                              ),
                                
                                        onPressed: () {
                                          _pickImage();
                                        },
                                        child: const Text('Sélectionner une photo de profil', style: TextStyle(
                                          color:  Color(0xFF2F9062),
                                          fontWeight: FontWeight.w900,
                                          
                                          ),),
                                      ),
                              
                                
                            ),
                            
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Color(0xfff5f8fd),
                                boxShadow: 
                                  [
                                    
                                    BoxShadow(  
                                        color: Colors.black12,
                                        offset: Offset(0.0,
                                            1.0),
                                        blurRadius: 5.0),
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 1.0),
                                  ],
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: TextFormField(
                              // obscureText: true,
                              controller: prenom_controller,
                              decoration: const InputDecoration(
                                hintText: "Prenom",
                                border: InputBorder.none,
                                prefixIcon:
                                Icon(Icons.account_circle, color: Color(0xFF2F9062),),
                              ),
                            ),
                          ),
        
                          const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              decoration: const BoxDecoration(
                                  color: Color(0xfff5f8fd),
                                  boxShadow: 
                                  [
                                    
                                    BoxShadow(  
                                        color: Colors.black12,
                                        offset: Offset(0.0,
                                            1.0),
                                        blurRadius: 5.0),
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 1.0),
                                  ],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                                child: TextFormField(
                                // obscureText: true,
                                  controller: nom_controller,
                                decoration: const InputDecoration(
                                  hintText: "Nom",
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.account_circle, color: const Color(0xFF2F9062),),
                                ),
                              ),
                            ),
         
                          const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 5),
                              decoration: const BoxDecoration(
                                  color: Color(0xfff5f8fd),
                                  boxShadow: 
                                  [
                                    
                                    BoxShadow(  
                                        color: Colors.black12,
                                        offset: Offset(0.0,
                                            1.0),
                                        blurRadius: 5.0),
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 1.0),
                                  ],
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
                              boxShadow: 
                                  [
                                    
                                    BoxShadow(  
                                        color: Colors.black12,
                                        offset: Offset(0.0,
                                            1.0),
                                        blurRadius: 5.0),
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 1.0),
                                  ],
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
                              boxShadow: 
                                  [
                                    
                                    BoxShadow(  
                                        color: Colors.black12,
                                        offset: Offset(0.0,
                                            1.0),
                                        blurRadius: 5.0),
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 1.0),
                                  ],
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
             const SizedBox(height: 25),
              //Raised Buttons of sigup will appear.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
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
                  onPressed: _ajouterUtilisateur,
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
                                
                            // boxShadow: 
                            // [
                              
                            //   BoxShadow(  
                            //       color: Colors.black12,
                            //       offset: Offset(0.0,
                            //           10.0),
                            //       blurRadius: 15.0),
                            //   BoxShadow(
                            //       color: Colors.black12,
                            //       offset: Offset(0.0, 4.0),
                            //       blurRadius: 10.0),
                            // ]
                            ),
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
              const SizedBox(height: 40),
            ],
            
          ),
          
        ),
      ),
    );
  }
}
