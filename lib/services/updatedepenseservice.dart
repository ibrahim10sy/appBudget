import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/depensepage.dart';

class UpdateDepensesService{

  Future<Depenses> modifierdepense(Depenses depenses) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/Depenses/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'idDepenses': depenses.idDepenses,
        'description': depenses.description,
        'montant': depenses.montant,
        'date': depenses.date,
        'budget': depenses.budget,
        'utilisateur': depenses.utilisateur,
        'type': depenses.type
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("Hello");
      return Depenses.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(jsonDecode(response.body)["message"]);
    }
  }

}
