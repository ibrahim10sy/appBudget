import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
import '../model/utilisateur.dart';

class UtilisateurService extends ChangeNotifier {

  // static const String apiUrl = 'https://apibudget.onrender.com/utilisateur/create'; 
  // static const String apiUrl2 = 'https://apibudget.onrender.com/utilisateur/update2'; 
  static const String apiUrl = 'http://10.0.2.2:8080/utilisateur/create'; 
  static const String apiUrl2 = 'http://10.0.2.2:8080/utilisateur/update2'; 
   
  
  static Future<Utilisateur> ajouterUtilisateur({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    File? photos,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      
      if(photos != null){
        request.files.add(http.MultipartFile('photo',photos.readAsBytes().asStream(),photos.lengthSync(),filename : basename(photos.path)));
        // debugPrint("MMM======== "+photos.path);
      }

      
      request.fields['utilisateur'] = jsonEncode({
        'nom' : nom,
        'prenom' : prenom,
        'email' : email,
        'motDePasse' : motDePasse,
        'photos' : ""
      });
      var response = await request.send();
    
      var responsed = await http.Response.fromStream(response);
      if (response.statusCode == 201) {
        final responseData = json.decode(responsed.body);
        debugPrint(responsed.body);
        return Utilisateur.fromJson(responseData);
      } else {
        debugPrint(responsed.body);
        throw Exception('Impossible d\'ajouter l\'utilisateur');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de l\'ajout de l\'utilisateur : $e');
    }
  } 
    // UPDATE
       Future<Utilisateur> updateUtilisateur({
      required int idUtilisateur,
      required String nom,
      required String prenom,
      required String email,
      required String motDePasse,
      File? photos,
    }) async {
      try {
        var request = http.MultipartRequest('PUT', Uri.parse('$apiUrl2/$idUtilisateur'));
        // request.headers.addAll({"Authorization": "Bearer token"});

        if (photos != null) {
          request.files.add(
            http.MultipartFile('photo', photos.readAsBytes().asStream(), photos.lengthSync(),
                filename: basename(photos.path),
            ),
          );
        }

        request.fields['utilisateur'] = jsonEncode({
          'nom': nom,
          'prenom': prenom,
          'email': email,
          'motDePasse': motDePasse,
          'photos': "",
        });

        var response = await request.send();
        var responsed = await http.Response.fromStream(response);

        if (response.statusCode == 200) {
          final responseData = json.decode(responsed.body);
          return Utilisateur.fromJson(responseData);
        } else {
          throw Exception('Impossible de mettre à jour l\'utilisateur');
        }
      } catch (e) {
        throw Exception('Une erreur s\'est produite lors de la mise à jour de l\'utilisateur : $e');
      }
    }
    // ENDUPDATE

    void applyChange(){
    notifyListeners();
  }
}