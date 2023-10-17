import 'dart:convert';


// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/provider/CategoriesProvider.dart';
import 'package:ika_musaka/screens/Categorie.dart';
import 'package:provider/provider.dart';

class CategorieService {
  static const String apiUrl = 'http://localhost:8080/Categorie';

  static Future<void> addCategorie({required BuildContext context,required String titre}) async {
    Map<String, dynamic> user = {
      "idUtilisateur": 1,
      "username": "SARA",
      "nom": "COULIBY",
      "email": "sc523644@gmail.com",
      "motDePasse": "1234"
    };
    // {
    //   "idUtilisateur":1
    // };
    var categories =
        jsonEncode({'idCategorie': null, 'titre': titre, 'utilisateur': user});
     // CategoriesProvider categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
      //context.watch<CategoriesProvider>().categories.add(categories);
     // context.read<CategoriesProvider>().addItem({'idCategorie': null, 'titre': titre, 'utilisateur': user});
    final response = await http.post(
      Uri.parse('$apiUrl/creer'),
      headers: {'Content-Type': 'application/json'},
      body: categories,
    );
    debugPrint(categories);
    if (response.statusCode == 200) {
      print("je vais te printer le retour json");
       context.read<CategoriesProvider>().addItem(jsonDecode(response.body));
      print(response.body);
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception('Categorie non ajouter');
    }
  }

  List<Categoriees> categories = [];
  //recuperation

  Future fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/Categorie/lire'));
 //print(response);

    if (response.statusCode == 200) {
      print("Bienvenu au categorie");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to lire');
    }
  }

 /*static Future<void> updateCategorie({required int id, required String titre}) async {
  final response = await http.put(
    Uri.parse('$apiUrl/modifier/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'titre': titre}),
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Impossible de modifier la catégorie');
  }
}*/

 // modifier
  static Future<void> updateCategorie(
      {required BuildContext context,required int index,required dynamic categorie}) async {
    Map<String, dynamic> user = {
     "idUtilisateur": 1,
      "username": "SARA",
      "nom": "COULIBY",
      "email": "sc523644@gmail.com",
      "motDePasse": "1234"
    };

    final response = await http.put(
      Uri.parse(
          '$apiUrl/modifier'), // Utilisez l'URL de mise à jour de votre API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(categorie),
    );

    if (response.statusCode == 200) {
      context.read<CategoriesProvider>().editItem(index, categorie);
      // La catégorie a été mise à jour avec succès.
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception(response.body);
    }
  }
  //////////suppression
  static Future<void> suppresion({required int id,required String titre}) async {
    print("je commence la supprimer");
    Map<String, dynamic> user = {
      "idUtilisateur": 1,
      "username": "SARA",
      "nom": "COULIBY",
      "email": "sc523644@gmail.com",
      "motDePasse": "1234"
    };
    // {
    //   "idUtilisateur":1
    // };
    var categories =
        jsonEncode({'idCategorie': 1, 'titre': titre, 'utilisateur': user});

    final response = await http.delete(
      Uri.parse('$apiUrl/Supprimer/$id'),
      headers: {'Content-Type': 'application/json'},
      body: categories,
    );
    debugPrint(categories);
    if (response.statusCode == 200) {
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception('Categorie non supprimer');
    }
  }
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
