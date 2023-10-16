import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../model/Depense.dart';

class DepenseService {
  static const String apiUrl = 'http://10.0.2.2:8080/Depenses/create'; // Mettez à jour l'URL correcte

  static Future<Depense> ajouterDepense({
    required String description,
    required double montant,
    required String type,
    required DateTime date,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

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
        return Depense.fromJson(responseData);
      } else {
        debugPrint(responsed.body);
        throw Exception('Impossible d\'ajouter la dépense');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de l\'ajout de la dépense : $e');
    }
  }
}
