import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../screens/depensepage.dart';

class SupprimerDepensesService{
  Future<String> supprimerdepense(int id) async{
  final response = await http.delete(
    Uri.parse('http://10.0.2.2:8080/Depenses/delete/${id}'),
    // Uri.parse('https://apibudget.onrender.com/Depenses/delete/${id}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if(response.statusCode == 200){
    return "Success";
  }else{
    throw Exception(jsonDecode(response.body)["message"]);
  }
  }
}