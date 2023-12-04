import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/NotificationModel.dart';

class NotificationService extends ChangeNotifier {
  final String baseUrl = "http://10.0.2.2:8080/notification/list/";

  Future<List<NotificationModel>> getNotifForUser(int idUtilisateur) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$idUtilisateur'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        List<NotificationModel> notifications =
            body.map((e) => NotificationModel.fromMap(e)).toList();
        print('Résultat attendu : ${response.statusCode}');
        debugPrint('notif service ${response.body}');
        return notifications;
      } else {
        print(
            'Échec de la requête du notif avec le code d\'état: ${response.statusCode}');
        throw Exception(
            jsonDecode(utf8.decode(response.bodyBytes))["message"]);
      }
    } catch (error) {
      print('Erreur lors de la récupération des notifications: $error');
      throw error;
    }
  }
}
