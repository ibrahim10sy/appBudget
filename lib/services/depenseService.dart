import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/DepenceClasse.dart';
import 'package:ika_musaka/model/types.dart';
import 'package:ika_musaka/model/utilisateur.dart';

import '../model/Budget.dart';

class DepenseService extends ChangeNotifier {
  final String url = "http://10.0.2.2:8080/Depenses/";
  final String url1 = "http://10.0.2.2:8080/Depenses/create";

  List<DepenseClass> depenses = [];
  String action = "all";
  String desc = "";
  String sortValue ="";

  Future<Map<String, dynamic>> getBudgetTotal(String endpoint) async{
    final response = await http.get(Uri.parse(url+endpoint));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<DepenseClass>> getDepenseByIdUser(int idBudget) async{
    final response = await http.get(Uri.parse("$url$idBudget/read"));
    debugPrint("$url$idBudget");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      depenses = body.map((dynamic item) => DepenseClass.fromJson(item)).toList();
      return depenses;
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<DepenseClass>> getDepenseByIdBudget(int idBudget) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/Depenses/$idBudget'));
    // debugPrint("$url$idBudget");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      depenses = body.map((dynamic item) => DepenseClass.fromJson(item)).toList();
      return depenses;
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<void> deleteBudgetById(String endpoint) async{
    final response = await http.delete(Uri.parse(url+endpoint));
    debugPrint("${response.statusCode}");

    if(response.statusCode == 200){
      applyChange();
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<DepenseClass>> searchDepenseByDesc(int idUser) async{
    final response = await http.get(Uri.parse("${url}search/$idUser?desc=$desc"));
    debugPrint("${url}search/$idUser?desc=$desc");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      depenses = body.map((dynamic item) => DepenseClass.fromJson(item)).toList();
      return depenses;
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<DepenseClass>> sortByMonthAndYear(int idUser) async{
    final response = await http.get(Uri.parse("${url}trie/$idUser?date=$sortValue"));
    debugPrint("${url}trie/$idUser?date=$sortValue");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      depenses = body.map((dynamic item) => DepenseClass.fromJson(item)).toList();
      return depenses;
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

 
static Future<void> ajouterDepense({
  required String description,
  required String montant,
  required String dateDepense,
  required Types type,
  required Budget budget,
  required Utilisateur utilisateur,
}) async {

  Map<String, int?> typeMap = {
    "idType": type.idType
  };
  Map<String,int?> ut = {
      "idUtilisateur" : utilisateur.idUtilisateur
    };
  Map<String,int?> bud = {
      "idBudget" : budget.idBudget
    };
  var depenses = jsonEncode({
    'description': description,
    'montant': int.parse(montant), 
    'type': type.toMap(),
    'date': dateDepense,
    'budget': budget.toMap(),
    'utilisateur': ut,
  });

  final response = await http.post(Uri.parse('http://10.0.2.2:8080/Depenses/create'),
    headers: {'Content-Type': 'application/json'},
    body: depenses,
  );
 

  if (response.statusCode == 200) {
    debugPrint(response.body);
    debugPrint(depenses.toString());
  } else {
    debugPrint(response.body);
    throw Exception('Impossible d\'ajouter une dépense ${response.statusCode}');
  }
}

  

  void applyChange(){
    notifyListeners();
  }

  void applySearch(String value){
    action = "search";
    desc = value;
    applyChange();
  }

  void applyTrie(String value){
    action = "trie";
    sortValue = value;
    applyChange();
  }
}