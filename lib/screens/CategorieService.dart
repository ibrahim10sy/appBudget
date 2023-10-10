import 'dart:convert';
import 'dart:js';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/Categorie.dart';

class CategorieService {
  static const String apiUrl = 'http://localhost:8083/Categorie';

  static Future<void> addCategorie({required String titre}) async {
    Map<String, dynamic> user = {
      "idUtilisateur": 1,
      "username": "SARA",
      "nom": "COULIBY",
      "prenom": "SAR",
      "email": "sc523644@gmail.com",
      "motDePasse": "1234"
    };
    // {
    //   "idUtilisateur":1
    // };

    var categories =
        jsonEncode({'idCategorie': null, 'titre': titre, 'utilisateur': user});

    final response = await http.post(
      Uri.parse('$apiUrl/creer'),
      headers: {'Content-Type': 'application/json'},
      body: categories,
    );
    debugPrint(categories);
    if (response.statusCode == 200) {
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception('Categorie non ajouter');
    }
  }

  // ouss
  List<Categorie> categories = [];
  //recuperation

  Future<List> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://localhost:8083/Categorie/lire'));
//print(response);
    if (response.statusCode == 200) {
      var cat = response.body;
      //  final List<dynamic> data = jsonDecode(response.body);
      //     categories = data.map((item) => Categorie.fromJson(item) as Categorie).toList();
      print("Bienvenu dans le console");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(jsonDecode(response.body));
      
      // return categories;
      var catg = jsonDecode(response.body);
      print(catg);

       return catg;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed list');
    }
  }

  //affichage sur l'interface
}




  // static const String apiUrl = 'http://localhost:8083/Categorie';

  // static Future<CategorieM> ajouterCategorie({
  //   required String titre,
  // }) async {
    
  //   final response = await http.post(
  //     Uri.parse('$apiUrl/creer'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({"idCategorie": null, "titre": titre}),
  //   );

  //   if (response.statusCode == 200) {
  //     return CategorieM.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Impossible d\'ajouter une catégorie');
  //   }
  // }