import 'dart:convert';

// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/provider/CategoriesProvider.dart';
import 'package:ika_musaka/screens/Categorie.dart';
import 'package:provider/provider.dart';

class CategorieService extends ChangeNotifier {
  // static const String apiUrl = 'https://apibudget.onrender.com/Categorie';
  // static const String apiUrl2 = 'https://apibudget.onrender.com/Categorie/list';
  static const String apiUrl = 'http://10.0.2.2:8080/Categorie';
  static const String apiUrl2 = 'http://10.0.2.2:8080/Categorie/list';
  List<dynamic> categorieListe = [];

  Future<String> addCategorie({
    required BuildContext context,
    required String titre,
    required Utilisateur utilisateur
    }) async {
    Map<String, dynamic> user = {
      "idUtilisateur": utilisateur.idUtilisateur,
      "prenom":utilisateur.prenom,
      "nom":utilisateur.nom,
      "email": utilisateur.email,
      "motDePasse": utilisateur.motDePasse
    };
    // {
    //   "idUtilisateur":1
    // };
    var categories =
        jsonEncode({
          'idCategorie': null, 
          'titre': titre, 
          'utilisateur': user
          });
    
    final response = await http.post(
      Uri.parse('$apiUrl/creer'),
      headers: {'Content-Type': 'application/json'},
      body: categories,
    );
    //debugPrint(categories);
    if (response.statusCode == 200) {
      print("je vais te printer le retour json");
      print(response.body);
      applyChange();
      print("je vais te");
      return "succes";
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
        await http.get(Uri.parse('http://10.0.2.2:8080/Categorie/lire'));
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
  Future catByUser(int id) async {
    final response =
        await http.get(Uri.parse('$apiUrl2/$id'));
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

 // modifier
 Future<void> updateCategorie(
      {required BuildContext context,required int index,required dynamic categorie}) async {
   

    final response = await http.put(
      Uri.parse(
          '$apiUrl/modifier'), // Utilisez l'URL de mise à jour de votre API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(categorie),
    );

    if (response.statusCode == 200) {
       applyChange();
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception(response.body);
    }
  }
  //////////suppression
  Future<void> suppresion({required int id,required String titre, required Utilisateur utilisateur}) async {
    print("je commence la supprimer");
   Map<String, dynamic> user = {
      "idUtilisateur": utilisateur.idUtilisateur,
      "prenom":utilisateur.prenom,
      "nom":utilisateur.nom,
      "email": utilisateur.email,
      "motDePasse": utilisateur.motDePasse
    };
    
    var categories =
        jsonEncode({'idCategorie': 1, 'titre': titre, 'utilisateur': user});

    final response = await http.delete(
      Uri.parse('$apiUrl/Supprimer/$id'),
      headers: {'Content-Type': 'application/json'},
      body: categories,
    );
    debugPrint(categories);
    if (response.statusCode == 200) {
      applyChange();
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint(response.body);
      throw Exception('Categorie non supprimer');
    }
  }
  
void applyChange(){
    notifyListeners();
  }
}
