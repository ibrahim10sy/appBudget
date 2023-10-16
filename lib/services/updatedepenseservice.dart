import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/DepenceClasse.dart';
import 'package:ika_musaka/screens/depensepage.dart';

class UpdateDepensesService{

  Future<DepenseClass> modifierdepense(DepenseClass depenses) async {
    final response = await http.put(
      Uri.parse('https://buget-service-api-git.onrender.com/Depenses/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'idDepenses': depenses.idDepense,
        'description': depenses.description,
        'montant': depenses.montant,
        'date': depenses.date,
        'budget': {
          'idBudget' : depenses.budget!.idBudget
        },
        'utilisateur': {
          'idUtilisateur' : depenses.utilisateur!.idUtilisateur
        },
        'type': {
          'idType' : depenses.type!['idType']
        }
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("Hello");
      return DepenseClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

}
