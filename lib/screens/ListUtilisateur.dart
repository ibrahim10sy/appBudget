
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/utilisateur.dart';

Future<List<Utilisateur>> fetchUtilisateurs() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/utilisateur/read'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final List<Utilisateur> utilisateurs = jsonData.map((e) => Utilisateur.fromJson(e)).toList();
    return utilisateurs;
  } else {
    throw Exception('Failed to load utilisateurs');
  }
}



class ListUtilisateur extends StatefulWidget {
  const ListUtilisateur({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListUtilisateurState createState() => _ListUtilisateurState();
}

class _ListUtilisateurState extends State<ListUtilisateur> {
  List<Utilisateur> utilisateurs = [];
  String messageError = "";
  late Future<List<Utilisateur>> futureUtilisateurs;

  @override
  void initState() {
    super.initState();
    futureUtilisateurs = fetchUtilisateurs();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Utilisateurs'),
      ),
        body: FutureBuilder<List<Utilisateur>>(
          future: futureUtilisateurs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // En cours de chargement
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}'); // En cas d'erreur
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Aucun utilisateur trouvé.'); // Aucun utilisateur dans la liste
            } else {
              // Liste des utilisateurs
              final utilisateurs = snapshot.data;
              return ListView.builder(
                itemCount: utilisateurs?.length,
                itemBuilder: (context, index) {
                  final utilisateur = utilisateurs?[index];
                  return ListTile(
                    title: Text('Nom: ${utilisateur?.nom}'),
                    subtitle: Text('Email: ${utilisateur?.email}'),
                  );
                },
              );
            }
          },
        )

    );
  }
}
