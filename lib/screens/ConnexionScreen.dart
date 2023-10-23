
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ika_musaka/screens/accueil.dart';
import 'package:ika_musaka/screens/bottomNavigatorBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/InscriptionScreen.dart';
import 'package:http/http.dart' as http;

import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
   // ignore: library_private_types_in_public_api
   _ConnexionState createState() => _ConnexionState();
}
class _ConnexionState extends State<Connexion> {
  TextEditingController emailController = TextEditingController();
  TextEditingController motDePasseController = TextEditingController();



Future<void> signInWithGoogle(BuildContext context) async {
  try {
    // Déclenche le flux d'authentification Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtient les détails d'authentification à partir de la demande
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crée une nouvelle crédentiation
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Une fois connecté, renvoie UserCredential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Redirige vers la page d'accueil en cas de succès de la connexion
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accueil()),
      );
    } else {
      debugPrint('L\'utilisateur a annulé la connexion Google');
      throw Exception('L\'utilisateur a annulé la connexion Google');
    }
  } catch (e) {
    // Gérer les erreurs, par exemple, en affichant un message d'erreur à l'utilisateur.
    debugPrint('Erreur de connexion Google: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur de connexion Google'),
          content: Text('Une erreur s\'est produite lors de la connexion Google.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

//   Future<UserCredential> signInWithGoogle(BuildContext context) async {
// //   try {
// //     // Déclenche le flux d'authentification Google
// //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //     if (googleUser != null) {
// //       // Obtient les détails d'authentification à partir de la demande
// //       final GoogleSignInAuthentication googleAuth =
// //           await googleUser.authentication;

// //       // Crée une nouvelle crédentiation
// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );

// //       // Une fois connecté, renvoie UserCredential
// //       final userCredential =
// //           await FirebaseAuth.instance.signInWithCredential(credential);

// //       // Redirige vers la page d'accueil en cas de succès de la connexion
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => Accueil()),
// //       );

// //       return userCredential;
// //     } else {
// //       debugPrint('L\'utilisateur a annulé la connexion Google');
// //       throw Exception('L\'utilisateur a annulé la connexion Google');
// //     }
// //   } catch (e) {
// //     // Gérer les erreurs, par exemple, en affichant un message d'erreur à l'utilisateur.
// //     debugPrint('Erreur de connexion Google: $e');
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Erreur de connexion Google'),
// //           content: Text('Une erreur s\'est produite lors de la connexion Google.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //     return ;
// //   }
// // }


   // methode authentification google:::::::::::::::::::::::::::::
//   Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   if (googleUser != null) {
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;
        

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   } else {
//     debugPrint('L\'utilisateur a annulé la connexion Google');
//     throw Exception('L\'utilisateur a annulé la connexion Google');
//   }
// }


   Future<void> intializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Accueil()),
        );
        debugPrint('User is signed in!');
      }
    });
  }


  Future<void> loginUser() async {
    // /utilisateur/login
    final String baseUrl = 'http://10.0.2.2:8080/utilisateur'; // Remplacez par la base URL de votre API.
    // final String baseUrl = 'https://buget-service-api-git.onrender.com/utilisateur'; // Remplacez par la base URL de votre API.
    final String email = emailController.text;
    final String password = motDePasseController.text;
    UtilisateurProvider utilisateurProvider = Provider.of<UtilisateurProvider>(context, listen: false);

    if (email.isEmpty || password.isEmpty) {

      // Gérez le cas où l'email ou le mot de passe est vide.
       const String errorMessage = "Veillez remplir tout les champs ";
        // Gérez le cas où l'email ou le mot de passe est vide.
        showDialog(
          context:  context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: Text('Erreur')),
              content:const  Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:const  Text('OK'),
                ),
              ],
            );
          },
        );
      return;
    }
    const String endpoint = '/login';
    final Uri apiUrl = Uri.parse('$baseUrl$endpoint?email=$email&motDePasse=$password');

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Authentification réussie, vous pouvez gérer la réponse ici.
        // Par exemple, vous pouvez enregistrer le token d'authentification.
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        //final authToken = responseBody['authToken']; // Remplacez par le nom réel du champ d'authentification.
        // Enregistrez authToken ou effectuez d'autres actions nécessaires.
        emailController.clear();
        motDePasseController.clear();
        // Redirigez l'utilisateur vers la page suivante.
        // Créez un objet Utilisateur avec les informations nécessaires.
        Utilisateur utilisateur = Utilisateur(
          nom: responseBody['nom'], // Remplacez par les vrais noms de champs.
          prenom: responseBody['prenom'],
          photos: responseBody['photos'],
          motDePasse: password,
          email: email,
          idUtilisateur: responseBody['idUtilisateur'],
          // Autres champs...
        );
        // Créez une instance de la classe Utilisateur avec ces données.
        final utilisateurConnecte = utilisateur;
        // Affichez les informations de l'utilisateur dans votre interface utilisateur (UI).
        // Stockez l'utilisateur dans UtilisateurProvider.
        utilisateurProvider.setUtilisateur(utilisateur);
        Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNavigationPage()));
        // Navigator.pushNamed(
        //   context,
        //   '/BottomNavigationPage',
        //   arguments: utilisateurConnecte, // Passer l'objet utilisateurConnecte en tant qu'argument.
        // );
      } else {
        // Gérez les erreurs d'authentification ici, par exemple affichez un message d'erreur.
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message']; // Remplacez par le nom réel du champ d'erreur.
        // Affichez un message d'erreur à l'utilisateur.
         showDialog(
          context:  context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:  Center(child: Text('Connexion echouer !')),
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
      }
    } catch (e) {
      // Gérez les erreurs liées à la requête HTTP ici.
      print('Erreur de connexion: $e');
      // Affichez un message d'erreur générique ou effectuez d'autres actions nécessaires.
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs de texte avec des valeurs vides.
    emailController.clear();
    motDePasseController.clear();
    intializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Container(
          
         //For moving according to the screen when the keyboard popsup.
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: <Widget>[
                      
                      SizedBox(
                        child: Container(
                          height: 250,
                          width: 600,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            // child: Image.asset("assets/images/login1-removebg.png"),
                            child: Image.asset("assets/images/log.png"),
                           
                          ),
                         
                        ),
                        
                      ),
                      
                    ],
                  ),
                 
                  const SizedBox(height: 10),
// From here the login Credentials start.
                 //Pour la navigation
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // const  Text("Vous n'avez pas de compte?"),
                   MouseRegion(
                    cursor: SystemMouseCursors.click, // Définit le curseur en mode "pointer"
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inscription()),
                        );
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: const Text(
                          "Connexion",
                          
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF2F9062), 
                            decorationThickness: 4,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Color(0xFF2F9062), // Utilisez la couleur #2F9062
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
                            fontSize: 20,
                            color: Color.fromARGB(255, 27, 30, 29), // Utilisez la couleur #2F9062
                          ),
                        ),
                      ),
                    ),
                  )

                  ]),
                  const SizedBox(height: 10),


                    // je voudrais mettre le background cette container à cette blanc
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: const Color(0xffe1e2e3),
                        color: Colors.white,
                        
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.grey.withOpacity(0.5),
                            color: Color(0xffffffff),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                            
                          ),
                        ]),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         const SizedBox(height: 5),

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
                            child:  TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color:  Color(0xFF2F9062),
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
                              controller: motDePasseController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Mot de passe",
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.vpn_key, color: Color(0xFF2F9062),),
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
                    child: const Text(
                      "Mot de passe oublié ?",
                      style:  TextStyle(
                      color: Color(0xFFE4AF18), 
                      fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(height: 25),
                  
                  //From here the signin buttons will occur.

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: loginUser,
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
                      Expanded(child:
                      GestureDetector(
                        //Signin with google button.
                        onTap: () {
                          signInWithGoogle(context);
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
                                          0.0), // This offset is for making the the lenght of the shadow and also the brightness of the black color try seeing it by changing its values.
                                      blurRadius: 5.0),
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 1.0),
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
                            ),
                        ),
                      ),
                      ),
                    ],

                  ),

              
                ],
              )),
        ),
      ),
    );
  }
}
