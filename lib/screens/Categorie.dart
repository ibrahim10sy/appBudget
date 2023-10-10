import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/categorieM.dart';

class Categorie extends StatefulWidget {
  MyCategorie createState() => MyCategorie();
}

class MyCategorie extends State<Categorie> {
  TextEditingController titreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs de texte avec des valeurs vides.
    titreController.clear();
  }

  static const String apiUrl = 'http://localhost:8080/Categorie';

  static Future<CategorieM> ajouterCategorie({
    required String titre,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'titre': titre,
      }),
    );

    if (response.statusCode == 200) {
      return CategorieM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Impossible d\'ajouter une catégorie');
    }
  }

//Fin Logique pour l'appel api et la logique
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding:
              const EdgeInsets.only(bottom: 0, top: 0, left: 10, right: 10),
          margin: EdgeInsets.only(top: 17, right: 7, left: 7, bottom: 15),
           decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 25.0,
                    ),
                  ],
                ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              width: 80,
              height: 80,
              child: Image.asset("images/aaa.png"),
            ),
            Text(
              "Pablo Picasso",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ]),
        ),
        const SizedBox(height: 5),
        Container(
          margin: EdgeInsets.all(7),
          child: Stack(children: [
            Container(
              child: Image(
                image: AssetImage('images/ccc.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 60, left: 15),
              child: Text(
                "Catégories",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 190, left: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Popup pour l'ajout de categorie
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31)),
                            titlePadding: EdgeInsets.only(top: 0, left: 0),
                            title: Container(
                              // color: Color(0xFF2F9062),
                              //decoration: BoxDecoration(),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 8, left: 10, right: 8),
                                    child: Image(
                                      image: AssetImage('images/img.png'),
                                    ),
                                  ),
                                  Text(
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
                                Text(
                                  'Nom de la catégorie',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black12,
                                                  style: BorderStyle.solid,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: TextFormField(
                                                controller: titreController,
                                                decoration: InputDecoration(
                                                    hintText: 'Ma_Categorie'),
                                              ),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final titre =
                                                  titreController.text;

                                              if (titre == 0) {
                                                final String errorMessage =
                                                    "Catégorie existe déjà ";
                                                // Gérez le cas où l'email ou le mot de passe est vide.
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Center(
                                                          child:
                                                              Text('Erreur')),
                                                      content:
                                                          Text(errorMessage),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }
                                              try {
                                                final nouveauCategorie =
                                                    await ajouterCategorie(
                                                  titre: titre,
                                                );
                                                // La nouvelle utilCategorieisateur a été ajouté avec succès, vous pouvez gérer la réponse ici.
                                                print(
                                                    'Categorie ajouté avec succès');
                                                titreController.clear();
                                              } catch (e) {
                                                // Une erreur s'est produite lors de l'ajout de l'utilisateur, vous pouvez gérer l'erreur ici.
                                                //print('Erreur lors de l\'ajout de l\'utilisateur : $e');
                                                final String errorMessage =
                                                    e.toString();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Center(
                                                            child:
                                                                Text('Erreur')),
                                                        content:
                                                            Text(errorMessage),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('OK'),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 80),
                                              backgroundColor: const Color(
                                                  0xFF2F9062), // Button color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                            onPressed: ()=>Navigator.pop(context),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 80),
                                              backgroundColor: Color.fromARGB(
                                                  255,
                                                  230,
                                                  10,
                                                  10), // Button color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
        Container(
          margin: EdgeInsets.all(8),
          padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(40),
            //  boxShadow: [
            //  BoxShadow(
            //  color: Colors.black12,
            //  blurRadius: 25.0,

            //     ),
            //   ],
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(7),
                    padding: const EdgeInsets.only(top: 3, left: 4, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Liste Catégories",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F9062)),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(3),
                padding: const EdgeInsets.only(
                    right: 10, left: 10, top: 10, bottom: 1),
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 25.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image.asset('images/888.png'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Transport',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(1),
                          child: IconButton(
                            padding: EdgeInsets.only(left: 70),
                              icon: Icon(Icons.edit_sharp,
                                  color: Color(0xFF2F9062)),
                              onPressed: () {
                                //Popup pour modifier la catégorie
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(31)),
                                          titlePadding:
                                              EdgeInsets.only(top: 0, left: 0),
                                          title: Container(
                                            // color: Color(0xFF2F9062),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 8, left: 8),
                                                  child: Image(
                                                    image: AssetImage(
                                                        'images/img.png'),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 7),
                                                  child: (Icon(Icons.edit_sharp,
                                                      color:
                                                          Color(0xFF2F9062))),
                                                ),
                                                Text(
                                                  'Modifier la Catégorie',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF2F9062)),
                                                )
                                              ],
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Nom de la catégorie',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .black12,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          'Ma_Categorie'),
                                                            ),
                                                          )),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            // Your button's onPressed logic here
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              _formKey
                                                                  .currentState!
                                                                  .save();
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 3,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        80),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF2F9062), // Button color
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Modifier",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ), // Fin button ajouter
                                                      Padding(
                                                        // Debut button annuler
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: ElevatedButton(
                                                          onPressed: ()=>Navigator.pop(context),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            elevation: 3,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        80),
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    230,
                                                                    10,
                                                                    10), // Button color
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Annuler",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ));
                              }
                              // Fin modale pour modifier
                              ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Popup pour supprimer une categorie
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(31)),
                                    titlePadding:
                                        EdgeInsets.only(top: 0, left: 0),
                                    title: Container(
                                      // color: Color(0xFF2F9062),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 8, left: 8),
                                            child: Image(
                                              image:
                                                  AssetImage('images/img.png'),
                                            ),
                                          ),
                                          Center(
                                              child: Text(
                                            'Voulez vous supprimer cette \n catégorie ?',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2F9062)),
                                          ))
                                        ],
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Nom de la catégorie',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(top: 20),
                                              child: ElevatedButton(
                                                onPressed: ()=>Navigator.pop(context),
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 3,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15,
                                                      horizontal: 30),
                                                  backgroundColor:
                                                      Color.fromARGB(
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
                                                  "NON",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Les bouttons oui et non
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 40, top: 20),
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
                                                      horizontal: 30),
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
                                                  "OUI",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                        },
                      ),
                    )
                  ],
                ),
              ),
              //-----------------------Le veritable------------------------------------------------------------------
              const SizedBox(height: 5),
            ],
          ),
        )
      ])),
    );
  }
}
