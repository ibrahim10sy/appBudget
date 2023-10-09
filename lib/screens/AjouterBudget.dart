import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/BudgetService.dart';
import 'package:ika_musaka/screens/categoriess.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../model/ajoutBudget.dart';

class AjouterBudget extends StatefulWidget {
  const AjouterBudget({super.key});

  @override
  State<AjouterBudget> createState() => _AjouterBudgetState();
}

class _AjouterBudgetState extends State<AjouterBudget> {
  // ignore: non_constant_identifier_names
  TextEditingController description_control = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController montant_control = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController montantalert_control = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController categorie_control = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController datedebut_control = TextEditingController();
  int? catValue;
  late Categorie maCat;

  /*@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

  }*/

  late Future _mesCategories;

  @override
  void initState() {
    description_control.clear();
    montant_control.clear();
    montant_control.clear();
    montantalert_control.clear();
    categorie_control.clear();
    datedebut_control.clear();
    fetchAlbum();
    _mesCategories =
        http.get(Uri.parse('http://localhost:8083/Categorie/lire'));
    super.initState();
  }

  @override
  onDispose() {
    description_control.dispose();
    super.dispose();
  }

  Future fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://localhost:8083/Budget/list'));
//print(response);
    if (response.statusCode == 200) {
      print("Bienvenu dans le console");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    // fetchAlbum();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Positioned(
                  top: -20,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/images/signin.png'),
                          ),
                          SizedBox(
                              width:
                                  10), // Espacement entre le profil et le texte
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
                          Icon(Icons.notifications,
                              size: 40, color: Colors.amber),
                        ],
                      ),
                    ),
                  ),
                ),

                //contenanire en vert
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFF2F9062),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  //place image
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/piece.png"),
                      // Image(image: AssetImage('assets/images/piece.png')),
                      const SizedBox(height: 10),
                      //partie text
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ajout Budget',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),

                          //partie icon
                          SizedBox(width: 10),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Déscription"),
                                Card(
                                  child: TextField(
                                    controller: description_control,
                                    maxLines: 3,
                                    // style: TextStyle(height: 5),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        "assets/images/montant.png")),
                                Expanded(flex: 2, child: Text("Montant")),
                                Expanded(
                                    flex: 6,
                                    child: TextField(
                                      controller: montant_control,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        "assets/images/montant_alert.png")),
                                Expanded(
                                    flex: 3, child: Text("Montant alerte")),
                                Expanded(
                                    flex: 6,
                                    child: TextField(
                                      controller: montantalert_control,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        "assets/images/categories.png")),
                                Expanded(flex: 2, child: Text("Catégorie")),
                                Expanded(
                                    flex: 6,
                                    child: FutureBuilder(
                                      future: _mesCategories,
                                      builder: (_, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return DropdownButton(
                                              items: [], onChanged: (value) {});
                                        }

                                        if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }

                                        if (snapshot.hasData) {
                                          //debugPrint(snapshot.data.body.toString());
                                          final reponse =
                                              json.decode(snapshot.data.body)
                                                  as List;
                                          final mesCategories = reponse
                                              .map((e) => Categorie.fromMap(e))
                                              .toList();
                                          //debugPrint(mesCategories.length.toString());
                                          return DropdownButton(
                                              items: mesCategories
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(e.titre),
                                                        value: e.id,
                                                      ))
                                                  .toList(),
                                              value: catValue,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  catValue = newValue;
                                                  maCat = mesCategories
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          newValue);
                                                  debugPrint(
                                                      maCat.id.toString());
                                                });
                                              });
                                        }

                                        return DropdownButton(
                                            items: [], onChanged: (value) {});
                                      },
                                    ))
                                // TextField(
                                //   controller: categorie_control,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(
                                //       borderRadius:
                                //           BorderRadius.circular(20.0),
                                //     ),
                                //   ),
                                // )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            //palce calendrier
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                        "assets/images/calendrier.png")),
                                Expanded(
                                    flex: 4, child: Text("Date de création")),
                                Expanded(
                                    flex: 5,
                                    child: TextField(
                                      controller: datedebut_control,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    )),
                              ],
                            ),

                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () async {
                                final description = description_control.text;
                                final montant = montant_control.text;
                                final montantAlert = montantalert_control.text;
                                //final categorie = categorie_control.text;
                                final datedebut = datedebut_control.text;

                                if (description.isEmpty ||
                                    montant.isEmpty ||
                                    montantAlert.isEmpty ||
                                    datedebut.isEmpty) {
                                  //throw Exception("Tous les champs doivent être remplis.");
                                  final String errorMessage =
                                      "Tous les champs doivent etre chargé";

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Center(child: Text('Erreur')),
                                        content: Text(errorMessage),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }

                                try {
                                  await BudgetService.addBudget(
                                      description: description,
                                      montant: montant,
                                      montantAlert: montantAlert,
                                      datedebut: datedebut,
                                      categorie: maCat);
                                  //setBudget(nouveauBudget);
                                  //print('Budget enregisté avc sucvès : ${nouveauBudget}');
                                  description_control.clear();
                                  montant_control.clear();
                                  montantalert_control.clear();
                                  datedebut_control.clear();
                                  categorie_control.clear();
                                } catch (e) {
                                  final String errorMessage = e.toString();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(child: Text('Erreur')),
                                          content: Text(errorMessage),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 13,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 55),
                                backgroundColor:
                                    const Color(0xFF2F9062), // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(color: Colors.white70),
                                ),
                              ),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F9062),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      "Ajouter",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE42E2E),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Annuler",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      // child: Container(
                      //   padding: const EdgeInsets.all(16),
                      //   color: const Color.fromARGB(255, 220, 213, 213),
                      //   child: Column(
                      //     //crossAxisAlignment: CrossAxisAlignment.stretch,
                      //     children: [
                      //       Row(
                      //         children: [Expanded(child: Text("data")),
                      //          TextField()],
                      //       ),
                      //       const TextField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Description',
                      //         ),
                      //       ),
                      //       const SizedBox(height: 10),
                      //       const TextField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Montant',
                      //         ),
                      //       ),
                      //       const SizedBox(height: 10),
                      //       const TextField(
                      //         decoration: InputDecoration(
                      //           labelText: 'Alerte',
                      //         ),
                      //       ),
                      //       const SizedBox(height: 10),
                      //       DropdownButton<String>(
                      //         isExpanded: true,
                      //         items: <String>[
                      //           'Catégorie 1',
                      //           'Catégorie 2',
                      //           'Catégorie 3'
                      //         ].map((String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value),
                      //           );
                      //         }).toList(),
                      //         onChanged: (String? newValue) {
                      //           // Vous pouvez gérer la sélection ici
                      //         },
                      //         hint: Text('Sélectionnez une catégorie'),
                      //       ),
                      //       SizedBox(height: 10),
                      //       TextButton(
                      //         onPressed: () {
                      //           // Ouvrez le sélecteur de date (calendrier) ici
                      //         },
                      //         child: Text('Sélectionner une date'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    const Placeholder();
  }

  //void setBudget(Budget nouveauBudget) {}
}
