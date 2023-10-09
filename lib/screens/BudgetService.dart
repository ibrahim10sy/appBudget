import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/ajoutBudget.dart';
import 'package:ika_musaka/screens/categorie.dart';

class BudgetService{
  static const String apiUrl = 'http://localhost:8083/Budget';

  static Future<void> addBudget({
    required String description,
    required String montant,
    required String montantAlert,
    required String datedebut,
    required Categorie categorie

})async{
    Map<String,int?> cate = {
      "idCategorie": categorie.id
    };
    Map<String,int> ut = {
      "idUtilisateur" : 2
    };
    var budget = jsonEncode({
      'idBudget':null,
      'description': description,
      'montant': int.parse(montant),
      'montantAlerte' : int.parse(montantAlert),
      'dateDebut': datedebut,
      'categorie': cate,
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

