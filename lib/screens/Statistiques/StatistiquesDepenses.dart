import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../model/DepenceClasse.dart';
import '../../model/utilisateur.dart';
import '../../provider/UtilisateurProvider.dart';
import '../../services/depenseService.dart';

class StatistiquesDepenses extends StatefulWidget {
//  final DepenseClass depenses; 
  

  const StatistiquesDepenses({Key? key, }) : super(key: key);

  @override
  _StatistiquesDepensesState createState() => _StatistiquesDepensesState();
}

class _StatistiquesDepensesState extends State<StatistiquesDepenses> {
  late Map<String, int> categories;
  late Future<Map<String, dynamic>> future;
  late Future<List<DepenseClass>> _futureListDepense;
  late List<DepenseClass> depenses = [];
  late Utilisateur utilisateur;
  var depenseService = DepenseService();
  @override
  void initState() {
    utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
    depenseService.getDepenseByIdUser(utilisateur.idUtilisateur).then((value) {
      depenses = value;
    });
    super.initState();
    
    categories = _calculateCategories();
  }

  
  Map<String, int> _calculateCategories() {
    Map<String, int> calculatedCategories = {};
    for (var depense in depenses) {
      String typeDepense = depense.type?["titre"] as String;
      if (calculatedCategories.containsKey(typeDepense)) {
        calculatedCategories[typeDepense] =
            (calculatedCategories[typeDepense]! + depense.montant!) as int;
      } else {
        calculatedCategories[typeDepense] = depense.montant!;
      }
    }
    return calculatedCategories;
  }

  Color _getColorFromCategory(String category) {
    switch (category) {
      case 'Nourriture':
        return Colors.grey;
      case 'Loyer':
        return Colors.blue;
      case 'Loisir':
        return Colors.pink;
      case 'Transport':
        return Colors.amberAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
           Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 15.0, left: 15, right: 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 7.0,
                            color: Color.fromRGBO(
                                0, 0, 0, 0.25) //Color.fromRGBO(47, 144, 98, 1)
                            )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    240, 176, 2, 1),
                                            radius: 30,
                                            child: Text(
                                              "${utilisateur!.nom.substring(0, 1).toUpperCase()}${utilisateur.prenom.substring(0, 1).toUpperCase()}",
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
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: badges.Badge(
                                position: badges.BadgePosition.topEnd(
                                    top: -2, end: -2),
                                badgeContent: const Text(
                                  "3",
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Color.fromRGBO(240, 176, 2, 1),
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                  ))),
          SizedBox(
            height: 30,
            child: PieChart(
              PieChartData(
                sections: categories.entries
                    .map((e) => PieChartSectionData(
                          value: e.value.toDouble(),
                          title: e.key,
                          color: _getColorFromCategory(e.key),
                        ))
                    .toList(),
              ),
            ),
          ),
          // ... Autres éléments de votre interface utilisateur
        ],
      ),
    );
  }
}
