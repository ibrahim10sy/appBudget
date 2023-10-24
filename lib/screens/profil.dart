import 'package:flutter/material.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/screens/ProfilUtilisateur.dart';
import 'package:provider/provider.dart';
import '../provider/UtilisateurProvider.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

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
      appBar : AppBar(
      backgroundColor: const Color.fromRGBO(47, 144, 98, 1),
        title : Text(
          'Mon profil',
          style: TextStyle(
            fontSize : 25
          ),
          ),
        centerTitle : true
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.symmetric(horizontal: 51),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Consumer<UtilisateurProvider>(builder: (context, value, child) {
                return utilisateur.photos == null || utilisateur.photos!.isEmpty
                  ? Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color.fromRGBO(47, 144, 98, 1),
                        radius: 120,
                        child: Text(
                          "${utilisateur.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "${utilisateur.prenom.toUpperCase()} ${utilisateur.nom.toUpperCase()}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "${utilisateur.email}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                  : Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(utilisateur.photos!),
                        backgroundColor: Color.fromRGBO(47, 144, 98, 1),
                        radius: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "${utilisateur.prenom.toUpperCase()} ${utilisateur.nom.toUpperCase()}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "${utilisateur.email}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  );
              },),
              SizedBox(height: 40,),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilUtilisateur()),
                  );
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color.fromRGBO(47, 144, 98, 1),
                  )),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                ),
                child: Text(
                  'Modifier profil',
                  style: TextStyle(
                    color: Color.fromRGBO(47, 144, 98, 1),
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              OutlinedButton(
                onPressed: () {
                  
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color.fromRGBO(47, 144, 98, 1),
                  )),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                ),
                child: Text(
                  'Déconnexion',
                  style: TextStyle(
                    color: Color.fromRGBO(47, 144, 98, 1),
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
