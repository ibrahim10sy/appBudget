import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/Budget.dart';

class BudgetController extends GetxController {

  final String url = "http://10.0.2.2:8080/Budget/";
  
  List<Budget> budgets = [];
  late Future<List<Budget>> futureListBudget;
  late Future<Map<String, dynamic>> future;
  @override
  onInit(){
    futureListBudget = getBudgetByIdUser("list/1");
    future = getBudgetTotal("somme/3");
    super.onInit();
  }

  Future<Map<String, dynamic>> getBudgetTotal(String endpoint) async{
    final response = await http.get(Uri.parse(url+endpoint));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("erreur");
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
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  Future<void> deleteBudgetById(String endpoint) async{
    final response = await http.delete(Uri.parse(url+endpoint));
    debugPrint("${response.statusCode}");

    if(response.statusCode == 200){
      budgets.removeLast();
      update(['listBudgets']);
    }else{
      throw Exception(jsonDecode(utf8.decode(response.bodyBytes))["message"]);
    }
  }

  void applyChange(){
    update();
  }
}