import 'package:flutter/material.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../provider/UtilisateurProvider.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late Utilisateur utilisateur;

  @override
  void initState() {
    super.initState();
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
         margin: EdgeInsets.all(160),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(utilisateur.photos!), radius: 30),
        ],
      ),
    ));
  }
}
