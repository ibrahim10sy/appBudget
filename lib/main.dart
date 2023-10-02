
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/screens/ConnexionScreen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
  //  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: "LogIn Screen",
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const Connexion()
      );//Place SignUp function here to Observe SignUp Screen.
  }
  //koureissi
}
class Utilisateur {
  final String username;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final int id;

  Utilisateur({required this.username, required this.nom,required this.prenom,required this.email,required this.motDePasse,required this.id});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      username: json["username"],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      id: json['id'],
    );
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

  Future<List<Utilisateur>> fetchUtilisateurs() async {
    final response = await http.get(Uri.parse('http://localhost:8000/utilisateur/read'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      utilisateurs = jsonData.map((e) => Utilisateur.fromJson(e)).toList();
      print(utilisateurs);
      return utilisateurs;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUtilisateurs().then((data) {
      setState(() {
        utilisateurs = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Utilisateurs'),
      ),
      body: ListView.builder(
        itemCount: utilisateurs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Nom: ${utilisateurs[index].nom}'),
            subtitle: Text('Email: ${utilisateurs[index].email}'),
          );
        },
      ),
    );
  }
}

 
