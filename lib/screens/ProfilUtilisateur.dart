import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/utilisateur.dart';

class ProfilUtilisateur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupérer les données de l'utilisateur passées en argument.
    final utilisateur = ModalRoute.of(context)!.settings.arguments as Utilisateur;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil de ${utilisateur.prenom}'),
      ),
      body: Column(
        children: [
          Text('Nom: ${utilisateur.nom}'),
          Text('Prénom: ${utilisateur.prenom}'),
          Text('Email: ${utilisateur.email}'),
          // Autres informations de l'utilisateur...
        ],
      ),
    );
  }
}
