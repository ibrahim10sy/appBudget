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
        backgroundColor: const Color.fromRGBO(47, 144, 98, 1),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(47, 144, 98, 1),
          title: const Text(
            "Profil",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Expanded(
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80.0),
                              topRight: Radius.circular(
                                  80.0), // Arrondir le coin supérieur droit
                            ),
                          ),
                          height: MediaQuery.of(context).size.height *
                              0.7, // 80% de la hauteur de l'écran
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 160),
                              Consumer<UtilisateurProvider>(builder:
                                  (context, utilisateurprovider, child) {
                                final user = utilisateurprovider.utilisateur;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Nom : ${user!.nom.toUpperCase()} ${user.prenom.toUpperCase()}",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Email : ${user.email}",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilUtilisateur()),
                                  );
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                    color: Color.fromRGBO(47, 144, 98, 1),
                                  )),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10)),
                                ),
                                child: const Text(
                                  'Modifier profil',
                                  style: TextStyle(
                                    color: Color.fromRGBO(47, 144, 98, 1),
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          )),
                    )),
              ],
            ),
            Positioned(
              // bottom: 20,
              // left: 85,
              child: Consumer<UtilisateurProvider>(
                  builder: (context, utilisateurprovider, child) {
                final user = utilisateurprovider.utilisateur;
                return user?.photos == null || user?.photos?.isEmpty == true
                    ? CircleAvatar(
                        backgroundColor: const Color.fromRGBO(47, 144, 98, 1),
                        radius: 120,
                        child: Text(
                          "${user!.prenom.substring(0, 1).toUpperCase()}${user.nom.substring(0, 1).toUpperCase()}",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: SizedBox(
                          width: 210.0,
                          height: 210.0,
                          child: Image.network(
                            "http://10.0.2.2/${user!.photos!}",
                            // fit: BoxFit.fill,
                            fit: BoxFit
                                .cover, // ou BoxFit.contain, BoxFit.fill, etc.
                            // scale: 0.5,
                          ),
                        ));
              }),
            ),
          ],
        ));
  }
}
