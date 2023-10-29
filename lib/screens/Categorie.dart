// import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/model/categorieM.dart';
import 'package:ika_musaka/provider/CategoriesProvider.dart';
import 'package:ika_musaka/screens/CategorieService.dart';
import 'package:provider/provider.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:badges/badges.dart' as badges;

import '../model/utilisateur.dart';
import 'ActionCategorie.dart';

class Categoriees extends StatefulWidget {
  const Categoriees({Key? key}) : super(key: key);

  @override
  MyCategorie createState() => MyCategorie();

  static fromJson(item) {}
}

class MyCategorie extends State<Categoriees> {
  TextEditingController titre_controller = TextEditingController();
  late Utilisateur utilisateur;

  List<dynamic> categories = [];
  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    super.initState();
    // Initialisation des contrôleurs de texte avec des valeurs vides.
    titre_controller.clear();
    _chargerCategories();
  }

  final categorieService = CategorieService();
  Future<void> _chargerCategories() async {
    try {
      var categories = await CategorieService().fetchAlbum();
      Provider.of<CategorieService>(context, listen: false).categorieListe =
          categories;
    } catch (e) {
      // Gérer les erreurs ici
      print("L'erreur est servenue lors de la chargement" + e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) {},
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 15.0, left: 15, right: 15),
                  child: Container(
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
                            Consumer<UtilisateurProvider>(
                              builder: (context, utilisateurProvider, child) {
                                final utilisateur =
                                    utilisateurProvider.utilisateur;
                                return Row(
                                  children: [
                                    utilisateur?.photos == null ||
                                            utilisateur?.photos?.isEmpty == true
                                        ? CircleAvatar(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    240, 176, 2, 1),
                                            radius: 30,
                                            child: Text(
                                              "${utilisateur!.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  letterSpacing: 2),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                utilisateur!.photos!),
                                            radius: 30,
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
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
                                );
                              },
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
                              ),
                            )
                          ],
                        ),
                      ))),
              ///////////////////////////////contenanire en vert//////////////
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.all(7),
                child: Stack(children: [
                  Container(
                    child: const Image(
                      image: AssetImage('assets/images/ccc.png'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 60, left: 15),
                    child: const Text(
                      "Catégories",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 190, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Popup pour l'ajout de categorie
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  titlePadding:
                                      const EdgeInsets.only(top: 0, left: 0),
                                  title: Container(
                                    // color: Color(0xFF2F9062),
                                    //decoration: BoxDecoration(),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 10, right: 8),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/img.png'),
                                          ),
                                        ),
                                        const Text(
                                          'Ajouter Catégorie',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2F9062)),
                                        )
                                      ],
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Nom de la catégorie',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black12,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          titre_controller,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Ma Categorie'),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final titre =
                                                        titre_controller.text;
                                                    if (titre.isEmpty) {
                                                      const String
                                                          errorMessage =
                                                          "Champs titre doit être renseigner";
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Center(
                                                                  child: Text(
                                                                      'Erreur')),
                                                              content: const Text(
                                                                  errorMessage),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Ok'),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                      return;
                                                    }
                                                    await Provider.of<
                                                                CategorieService>(
                                                            context,
                                                            listen: false)
                                                        .addCategorie(
                                                            context: context,
                                                            titre: titre,
                                                            utilisateur:
                                                                utilisateur)
                                                        .then((value) {
                                                      titre_controller.clear();
                                                    }).catchError((onError) {
                                                      final String
                                                          errorMessage =
                                                          onError.toString();
                                                      // ignore: use_build_context_synchronously
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Center(
                                                                  child: Text(
                                                                      'Erreur')),
                                                              content: Text(
                                                                  errorMessage),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    });

                                                    Navigator.of(context)
                                                        .pop(); // Ferme la boîte de dialogue
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 3,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15,
                                                        horizontal: 80),
                                                    backgroundColor: const Color(
                                                        0xFF2F9062), // Button color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Ajouter",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ), // Fin button ajouter
                                              Padding(
                                                // Debut button annuler
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Your button's onPressed logic here
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }

                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 3,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15,
                                                        horizontal: 80),

                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255,
                                                            230,
                                                            10,
                                                            10), // Button color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Annuler",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ));
                      }, // Tout l'évenement de mon button ajouter catégorie
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        backgroundColor:
                            const Color(0xFF2F9062), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white70),
                        ),
                      ),
                      child: const Text(
                        " + Ajouter catégorie",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Tout l'evenement pour ouvrir la popup pour ajouter une nouvel catégorie
                  )
                ]),
              ),
              const SizedBox(height: 5),
              ////////////////////colonnes////////////
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  // Pour centrer les éléments verticalement
                  children: [
                    const Text(
                      "Liste de catégories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F9062), // Couleur du texte en vert
                      ),
                    ),

                    /////////////////////////////////////////liste////////////
                    const SizedBox(height: 5),
                    Expanded(
                      child: Consumer<CategorieService>(
                        builder: (context, categorieService, child) {
                          debugPrint("edcvfr");
                          return FutureBuilder(
                              future: categorieService
                                  .catByUser(utilisateur.idUtilisateur),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      final Map<String, dynamic> category =
                                          snapshot
                                              .data[index]; //categories[index];
                                      //print(category.toString());
                                      return Card(
                                        margin: const EdgeInsets.all(8),
                                        elevation:
                                            5, // Niveau d'élévation pour l'ombre
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: ListTile(
                                          leading: Image.asset(
                                              'assets/images/888.png'),
                                          title: Text(
                                            category["titre"],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 31, 31, 31),
                                            ),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.edit_sharp,
                                                    color: Color(
                                                        0xFF2F9062)), // Icône pour modifier

                                                onPressed: () async {
                                                  // print(category);
                                                  DialogHelper
                                                      .showModifyCategoryDialog(
                                                          context,
                                                          index,
                                                          category);

                                                  //  String newTitre = titre_controller.text;
                                                  // await CategorieService.updateCategorie(id: 1, titre: newTitre);
                                                  // Rafraîchir la liste
                                                  //await _chargerCategories();
                                                  // Fermeture du popup
                                                  //  Navigator.of(context).pop();
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete,
                                                    color: Color.fromARGB(
                                                        255,
                                                        255,
                                                        0,
                                                        0)), // Icône pour supprimer
                                                onPressed: () {
                                                  DialogHelper
                                                      .showDeleteCategoryDialog(
                                                          context,
                                                          category[
                                                              'idCategorie'],
                                                          index,
                                                          utilisateur);
                                                  // Logique pour la suppression ici
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
