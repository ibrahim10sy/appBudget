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
           Stack(
                    children: <Widget>[
                      
                      SizedBox(
                        child: Container(
                          height: 250,
                          width: 600,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            // child: Image.asset("assets/images/login1-removebg.png"),
                            child: Image.network(utilisateur.photos),
                           
                          ),
                         
                        ),
                        
                      ),
                      
                    ],
                  ),
          Text('Nom: ${utilisateur.nom}'),
          Text('Prénom: ${utilisateur.prenom}'),
          Text('Email: ${utilisateur.email}'),
          // Autres informations de l'utilisateur...
        ],
      ),
    );
  }
}
