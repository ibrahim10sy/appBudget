
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/Budget.dart';

class BudgetService extends ChangeNotifier {

  final String url = "http://10.0.2.2:8080/Budget/";
  
  List<Budget> budgets = [];
  String action = "all";
  String lastAction = "";
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

  Future<List<Budget>> getBudgetByIdUser(String endpoint) async{
    final response = await http.get(Uri.parse(url+endpoint));
    debugPrint(url+endpoint);
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      budgets = body.map((dynamic item) => Budget.fromJson(item)).toList();
      return budgets;
    }else{
      budgets = [];
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

  Future<List<Budget>> searchBudgetByDesc(int idUser) async{
    final response = await http.get(Uri.parse("${url}search/$idUser?desc=$desc"));
    debugPrint("${url}search/$idUser?desc=$desc");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      budgets = body.map((dynamic item) => Budget.fromJson(item)).toList();
      return budgets;
    }else{
      budgets = [];
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<List<Budget>> sortByMonthAndYear(int idUser) async{
    final response = await http.get(Uri.parse("${url}trie/$idUser?date=$sortValue"));
    debugPrint("${url}trie/$idUser?date=$sortValue");
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      budgets = body.map((dynamic item) => Budget.fromJson(item)).toList();
      return budgets;
    }else{
      budgets = [];
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  getBudgetById(int id){
    late Budget bud;
    budgets.forEach((element) {
      if(element.idBudget == id){
        bud = element;
      }
    });
    return bud;
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