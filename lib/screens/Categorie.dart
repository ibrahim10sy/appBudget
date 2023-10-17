// import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/model/categorieM.dart';
import 'package:ika_musaka/provider/CategoriesProvider.dart';
// import 'package:http/http.dart' as http;
// import 'package:ika_musaka/model/categorieM.dart';
import 'package:ika_musaka/screens/CategorieService.dart';
import 'package:provider/provider.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';

import 'ActionCategorie.dart';

class Categoriees extends StatefulWidget {
  const Categoriees({Key? key}) : super(key: key);

  @override
  MyCategorie createState() => MyCategorie();

  static fromJson(item) {}
}

class MyCategorie extends State<Categoriees> {
  
  TextEditingController titre_controller = TextEditingController();

  

List<dynamic> categories = [];
  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs de texte avec des valeurs vides.
    titre_controller.clear();
    _chargerCategories();
  }

  final categorieService = CategorieService();

  Future<dynamic> _chargerCategories() async {
    final loadedCategories = await categorieService.fetchAlbum();
    CategoriesProvider categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
      
    setState(() {
      categoriesProvider.setCategorie(loadedCategories);
      //categories = loadedCategories;
      print("je vais printer");
      //print(categoriesProvider.getCategories()[0]);
      print("fin du print");
      //categories = context.watch<CategoriesProvider>().categories;
     // debugPrint('reponse ${categories[0]["titre"]}');
    }); // Rafraîchir l'interface pour afficher les catégories
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) {  },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/signin.png'),
                        ),
                        SizedBox(
                            width: 10), // Espacement entre le profil et le texte
                        Text(
                          'Saran Coulibaly', // Remplacez par votre nom
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ///////////////////////////////contenanire en vert//////////////
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.all(7),
                child: Stack(children: [
                  Container(
                    child: const Image(
                      image: AssetImage('images/ccc.png'),
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
                                            image: AssetImage('images/img.png'),
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
                                                        style: BorderStyle.solid,
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
                                                padding: const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final titre =
                                                        titre_controller.text;
                                                    if (titre.isEmpty) {
                                                      const String errorMessage =
                                                          "Champs titre doit être charger";
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
                                                                  onPressed: () {
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
                                                    try {
                                                      await CategorieService
                                                          .addCategorie(context: context,
                                                              titre: titre);
      
                                                      titre_controller.clear();
                                                      
                                                    } catch (e) {
                                                      final String errorMessage =
                                                          e.toString();
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
                                                                  onPressed: () {
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
                                                    }
                                                    Navigator.of(context).pop(); // Ferme la boîte de dialogue
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 3,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 15,
                                                        horizontal: 80),
                                                    backgroundColor: const Color(
                                                        0xFF2F9062), // Button color
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      side: const BorderSide(
                                                          color: Colors.white70),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Ajouter",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ), // Fin button ajouter
                                              Padding(
                                                // Debut button annuler
                                                padding: const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Your button's onPressed logic here
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
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
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      side: const BorderSide(
                                                          color: Colors.white70),
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
                        backgroundColor: const Color(0xFF2F9062), // Button color
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
                      child: ListView.builder(
                        itemCount: context.watch<CategoriesProvider>().categories.length,
                        itemBuilder: (context, index) {
                          final category =  context.watch<CategoriesProvider>().categories[index];//categories[index];
                          //print(category.toString());
                          return Card(
                            margin: const EdgeInsets.all(8),
                            elevation: 5, // Niveau d'élévation pour l'ombre
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: ListTile(
                              leading: Image.asset('images/888.png'),
                              title: Text(
                                category["titre"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 31, 31, 31),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_sharp,
                                        color: Color(
                                            0xFF2F9062)), // Icône pour modifier
      
                                    onPressed: () async {
                                     // print(category);
                                      DialogHelper.showModifyCategoryDialog(
                                          context,index,category);
                                          
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
                                        color: Color.fromARGB(255, 255, 0, 0)), // Icône pour supprimer
                                    onPressed: () {
                                      
                                       DialogHelper.showDeleteCategoryDialog(
                                           context,category['idCategorie'],index);
                                      // Logique pour la suppression ici
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
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
