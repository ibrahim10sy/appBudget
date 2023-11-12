import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/categoriess.dart';

import '../model/utilisateur.dart';

class BudgetServices{
  // static const String apiUrl = 'https://apibudget.onrender.com/Budget';
  static const String apiUrl = 'http://10.0.2.2:8080/Budget';
  // static const String Url = 'http://10.0.2.2:8080/Budget/modifier';

  static Future<void> addBudget({
    required String description,
    required String montant,
    required String montantAlert,
    required String datedebut,
    required Categorie categorie,
    required Utilisateur utilisateur
})async{
    Map<String,int?> cate = {
      "idCategorie": categorie.id
    };
    Map<String,int> ut = {
      "idUtilisateur" : utilisateur.idUtilisateur
    };
    var budget = jsonEncode({
      'idBudget':null,
      'description': description,
      'montant': int.parse(montant),         
      'montantAlerte' : int.parse(montantAlert),
      'dateDebut': datedebut,
      'categorie': categorie.toMap(),
      'utilisateur' : ut
    });
    final response = await http.post(Uri.parse('$apiUrl/ajouter'),
    headers: {'Content-Type': 'application/json'},
    body: budget,
    );
    debugPrint(budget);
    if(response.statusCode == 200){

      //return Budget.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    }else{
      debugPrint(response.body);
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }
 

  
 static Future<void> updateBudget ({
    required int id,
    required String description,
    required String montant,
    required String montantAlert,
    required String montantRestant,
    required String datedebut,
    required Categorie categorie,
    required Utilisateur utilisateur
  }) async {
    Map<String, int?> cate = {
      "idCategorie": categorie.id
    };
    Map<String, int> ut = {
      "idUtilisateur": utilisateur.idUtilisateur
    };
    var budget = jsonEncode({
      'idBudget': id,
      'description': description,
      'montant': int.parse(montant),         
      'montantAlerte': int.parse(montantAlert),
      'montantRestant': int.parse(montantRestant),
      'dateDebut': datedebut,
      'categorie': categorie.toMap(),
      'utilisateur': ut
    });
    final response = await http.put(
      Uri.parse('$apiUrl/modifier'),
      headers: {'Content-Type': 'application/json'},
      body: budget,
    );
    debugPrint(budget);
    if (response.statusCode == 200) {
      // return Budget.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      debugPrint(response.body);
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  // Future <void> updateBudget({required BuildContext context, required int index, required dynamic budget}) async {
  //   final response = await http.put(
  //     Uri.parse('$apiUrl/modifier'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(budget),
  //   );

  //   if(response.statusCode == 200) {
  //     debugPrint(budget);
  //   }else{
  //     print('Une erreur s\'est produit lors de la modificario.${response.statusCode}');
  //   }
  // }
  }