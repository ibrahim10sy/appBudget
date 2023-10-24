import 'dart:io';
// import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/profil.dart';
import 'package:ika_musaka/services/UtilisateurService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../model/utilisateur.dart';
import 'package:path/path.dart' as pp;

class ProfilUtilisateur extends StatefulWidget {
  const ProfilUtilisateur({super.key});
  @override
  State<ProfilUtilisateur> createState() => _ProfilUtilisateurState();
}

class _ProfilUtilisateurState extends State<ProfilUtilisateur> {
  TextEditingController nom_controller = TextEditingController();
  TextEditingController prenom_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController motDepasse_controller = TextEditingController();
  TextEditingController RepmotDePasse_controller = TextEditingController();
  String? imageSrc;
  File? image;

  late Utilisateur utilisateur;

  @override
  void initState() {
    super.initState();
    utilisateur = Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    nom_controller.text = utilisateur.nom;
    prenom_controller.text = utilisateur.prenom;
    email_controller.text = utilisateur.email;
    RepmotDePasse_controller.text = utilisateur.motDePasse;
    motDepasse_controller.text = utilisateur.motDePasse;
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = pp.basename(imagePath);
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

  Future<void> _updateUtilisateur() async {
    final utilisateurId = utilisateur.idUtilisateur;
    final nom = nom_controller.text;
    final prenom = prenom_controller.text;
    final email = email_controller.text;
    final motDePasse = motDepasse_controller.text;

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty || motDePasse.isEmpty) {
      // Gérez le cas où l'email ou le mot de passe est vide.
      const String errorMessage = "Veuillez remplir tous les champs";
      debugPrint(errorMessage);
      return;
    }

    Utilisateur utilisateurMaj;

    try {
      if (image != null) {
        utilisateurMaj = await UtilisateurService.updateUtilisateur(
          idUtilisateur: utilisateur.idUtilisateur,
          nom: nom,
          prenom: prenom,
          email: email,
          motDePasse: motDePasse,
          photos: image as File,
        );
      } else {
        utilisateurMaj = await UtilisateurService.updateUtilisateur(
          idUtilisateur: utilisateur.idUtilisateur,
          nom: nom,
          prenom: prenom,
          email: email,
          motDePasse: motDePasse,
        );
      }
      // showDialog(context: context, 
      // builder: (BuildContext context){
      //   return AlertDialog(
      //     title: const Center(
      //       child:  Text('Succèss'),
      //     ),
      //     content: Text('Profil modifier avec succèss'),
      //     actions: <Widget>[
      //      TextButton(
      //        onPressed:() {
      //        Navigator.of(
      //        context).pop();},
      //         child:
      //          const Text(
      //           'Ok'),
      //        )
      //       ],                                                     
      //   );
      // }
      // );

      // Le profil utilisateur a été mis à jour avec succès, vous pouvez gérer la réponse ici.
      print(
          'Profil utilisateur mis à jour avec succès : ${utilisateurMaj.nom}');
      // Vous pouvez également gérer la navigation vers une autre page après la mise à jour.
    } catch (e) {
      // Une erreur s'est produite lors de la mise à jour du profil utilisateur, vous pouvez gérer l'erreur ici.
      final String errorMessage = e.toString();
      debugPrint(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer les données de l'utilisateur passées en argument.
    // final utilisateur = ModalRoute.of(context)!.settings.arguments as Utilisateur;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, top: 30, right: 15.0, bottom: 15.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 7.0,
                              color: Color.fromRGBO(0, 0, 0,
                                  0.25) //Color.fromRGBO(47, 144, 98, 1)
                              )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              utilisateur.photos == null ||
                                      utilisateur.photos!.isEmpty
                                  ? CircleAvatar(
                                      //backgroundImage: AssetImage("assets/images/avatar.png"),
                                      //  child: Image.network(utilisateur.photos),
                                      backgroundColor:
                                          const Color.fromRGBO(240, 176, 2, 1),
                                      radius: 30,
                                      child: Text(
                                        "${utilisateur.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(utilisateur.photos!),
                                      radius: 30),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "${utilisateur.prenom.toUpperCase()} ${utilisateur.nom.toUpperCase()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: badges.Badge(
                                position: badges.BadgePosition.topEnd(
                                    top: -2, end: -2),
                                badgeContent: const Text(
                                  "3",
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Color.fromRGBO(240, 176, 2, 1),
                                  size: 40,
                                ),
                              ))
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    // borderRadius: BorderRadius.circular(30),
                    child: (image != null)
                        ? Image.file(
                            image!,
                            //  height: 80,
                            //  width: 400,
                          )
                        : utilisateur.photos == null ||
                                utilisateur.photos!.isEmpty
                            ? CircleAvatar(
                                //backgroundImage: AssetImage("assets/images/avatar.png"),
                                //  child: Image.network(utilisateur.photos),
                                backgroundColor:
                                    const Color.fromRGBO(240, 176, 2, 1),
                                radius: 30,
                                child: Text(
                                  "${utilisateur.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(utilisateur.photos!),
                                radius: 30),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      // color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 45),
                      backgroundColor: const Color(0xFFffffff), // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Color(0xFF2F9062)),
                      ),
                    ),
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text(
                      'Sélectionner une photo de profil',
                      style: TextStyle(
                        color: Color(0xFF2F9062),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f8fd),
                      // color: Color(0xFF2A398E7),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    // obscureText: true,
                    controller: prenom_controller,
                    decoration: const InputDecoration(
                      hintText: "Prenom",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Color(0xFF2F9062),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f8fd),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    // obscureText: true,
                    controller: nom_controller,
                    decoration: const InputDecoration(
                      hintText: "Nom",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Color(0xFF2F9062),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f8fd),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    // obscureText: true,
                    controller: email_controller,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF2F9062),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f8fd),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: motDepasse_controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Mot de passe",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color(0xFF2F9062),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f8fd),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextFormField(
                    controller: RepmotDePasse_controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Repetermot de passe",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color(0xFF2F9062),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            width: double
                .infinity, // Cela permettra au conteneur de s'étendre sur toute la largeur.
            child: ElevatedButton(
              onPressed: (){
                _updateUtilisateur();

                Navigator.push(context, MaterialPageRoute(builder: (context) => Profil()));
                debugPrint(utilisateur.toString());
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: const Color(0xFF2F9062), // Couleur du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white70),
                ),
              ),
              child: const Text(
                "Modifier",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            width: double
                .infinity, // Cela permettra au conteneur de s'étendre sur toute la largeur.
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: const Color(0xFF2E42E2E), // Couleur du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white70),
                ),
              ),
              child: const Text(
                "Annuler",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )

          //end of input container
        ],
      ),
    );
  }
} 
   