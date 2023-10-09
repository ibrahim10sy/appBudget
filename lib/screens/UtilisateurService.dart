import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/utilisateur.dart';

class UtilisateurService {
  static const String apiUrl = 'http://10.0.2.2:8080/utilisateur';

  static Future<Utilisateur> ajouterUtilisateur({
    required String username,
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'motDePasse': motDePasse,
      }),
    );

    if (response.statusCode == 200) {
      return Utilisateur.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Impossible d\'ajouter l\'utilisateur');
    }
  }
}
