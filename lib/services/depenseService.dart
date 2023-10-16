import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/DepenceClasse.dart';

class DepenseService extends ChangeNotifier {
  final String url = "https://buget-service-api-git.onrender.com/Depenses/";

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
    final response = await http.get(Uri.parse("$url$idBudget"));
    debugPrint("$url$idBudget");
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

  Future<DepenseClass> ajouterDepense({
    required String description,
    required double montant,
    required String type,
    required DateTime date,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse("$url/create"));

      // Ajoutez les autres champs requis à la requête
      request.fields['depense'] = jsonEncode({
        'description': description,
        'montant': montant.toString(),
        'type': type,
        'date': date.toIso8601String(),
      });

      var response = await request.send();
      var responsed = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        final responseData = json.decode(responsed.body);
        debugPrint(responsed.body);
        return DepenseClass.fromJson(responseData);
      } else {
        debugPrint(responsed.body);
        throw Exception('Impossible d\'ajouter la dépense');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de l\'ajout de la dépense : $e');
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