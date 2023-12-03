import 'package:flutter/material.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/Categorie.dart';
import 'package:ika_musaka/services/BottomNavigationService.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:provider/provider.dart';

import '../model/DepenceClasse.dart';
import '../model/utilisateur.dart';
import 'Statistiques/StatistiquesDepenses.dart';
// import 'Statistiques/Statistiques.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  late Future<Map<String, dynamic>> future;
  late Utilisateur utilisateur;
  late DepenseClass depenses;

  @override
  void initState() {
    super.initState();
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    future =
        BudgetService().getBudgetTotal("somme/${utilisateur.idUtilisateur}");
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer les données de l'utilisateur passées en argument.
    // final utilisateur = ModalRoute.of(context)!.settings.arguments as Utilisateur;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, top: 30, right: 15.0, bottom: 15.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 7.0,
                              color: Color.fromRGBO(0, 0, 0,
                                  0.25) //Color.fromRGBO(47, 144, 98, 1)
                              )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<UtilisateurProvider>(
                            builder: (context, utilisateurProvider, child) {
                              final utilisateur =
                                  utilisateurProvider.utilisateur;
                              return Row(
                                children: [
                                  utilisateur?.photos == null ||
                                          utilisateur?.photos?.isEmpty == true
                                      ? CircleAvatar(
                                          backgroundColor: const Color.fromRGBO(
                                              240, 176, 2, 1),
                                          radius: 30,
                                          child: Text(
                                            "${utilisateur!.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              utilisateur!.photos!),
                                          radius: 30,
                                        ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "${utilisateur.prenom.toUpperCase()} ${utilisateur.nom.toUpperCase()}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          Image.asset(
                            "assets/images/wallet-budget-icon.png",
                            width: 50,
                            height: 50,
                          )
                        ],
                      ),
                    )),
                Stack(
                  alignment: const Alignment(0.9, -0.8),
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(
                            color: Colors.white,
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                              color: const Color.fromRGBO(47, 144, 98, 1),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 15.0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Budget total :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    Consumer<BudgetService>(
                                      builder: (context, bugetService, child) {
                                        return FutureBuilder<
                                                Map<String, dynamic>>(
                                            future: bugetService.getBudgetTotal(
                                                "somme/${utilisateur.idUtilisateur}"),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                    "${snapshot.data?["Total"]} CFA",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold));
                                              } else {
                                                return const CircularProgressIndicator(); //const CircularProgressIndicator();
                                              }
                                            });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                    Image.asset(
                      "assets/images/wallet-budget-icon.png",
                      width: 150,
                      height: 99,
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                _buildAccueilCard("Budget", "budget.png", 1),
                _buildAccueilCard("Dépense", "depenses 1.png", 2),
                _buildAccueilCard("Catégorie", "categorie.png", 3),
                _buildAccueilCard("Statistiques", "statistique_logo.png", 4)
                // _buildAccueilCard("Statistique", "statistique_logo.png", 4)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAccueilCard(String titre, String imgLocation, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (index == 4) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StatistiquesDepenses()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Categoriees()));
          } else {
            Provider.of<BottomNavigationService>(context, listen: false)
                .changeIndex(index);
          }
        },
        borderRadius: BorderRadius.circular(28),
        highlightColor: const Color.fromRGBO(47, 144, 98, 0.9),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/$imgLocation"),
              Text(
                titre,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
