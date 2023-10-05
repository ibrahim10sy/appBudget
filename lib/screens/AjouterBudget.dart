

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/ajoutBudget.dart';

class AjouterBudget extends StatefulWidget {
  const AjouterBudget({super.key});

  @override
  State<AjouterBudget> createState() => _AjouterBudgetState();

}

class _AjouterBudgetState extends State<AjouterBudget> {

  /*@override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

  }*/


  @override
  void initState() {
    fetchAlbum();
    
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
                const Positioned(
                  top: 0,
                  left: 30,
                  child: Row(
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
                    ],
                  ),
                ),

                //contenanire en vert
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
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
                            'Ajout',
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
                                    // controller: myController,
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
                                    child: TextField(
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
                                        "assets/images/calendrier.png")),
                                Expanded(
                                    flex: 4, child: Text("Date de création")),
                                Expanded(
                                    flex: 5,
                                    child: TextField(
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
                              onPressed: () {},
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F9062),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
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
                              onPressed: () {
                                // addBudget(bu);
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE42E2E),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
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
}
