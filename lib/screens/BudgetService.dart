import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/ajoutBudget.dart';
import 'package:ika_musaka/screens/categoriess.dart';

import '../model/utilisateur.dart';

class BudgetService{
  static const String apiUrl = 'https://buget-service-api-git.onrender.com/Budget';

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
      throw Exception('Budget non ajouter');
    }
  }
  }

