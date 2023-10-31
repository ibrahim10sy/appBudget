import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/model/stat_model.dart';
import 'package:provider/provider.dart';

import '../../model/DepenceClasse.dart';
import '../../model/utilisateur.dart';
import '../../provider/UtilisateurProvider.dart';
import '../../services/depenseService.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class StatistiquesDepenses extends StatefulWidget {
//  final DepenseClass depenses;

  const StatistiquesDepenses({
    Key? key,
  }) : super(key: key);

  @override
  _StatistiquesDepensesState createState() => _StatistiquesDepensesState();
}

class _StatistiquesDepensesState extends State<StatistiquesDepenses> {
  late Future<Map<String, dynamic>> future;
  List<StatModel> categories = [];
  late Future<List<StatModel>> _futureListDepense;
  List<DepenseClass> depenses = [];
  late Utilisateur utilisateur;
  var depenseService = DepenseService();
  @override
  void initState() {
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    _futureListDepense = getCategories();
    // depenseService.getDepenseByCategory(1).then((value) {
    //   categories = value;
    // });
    //  categories = depenseService.getDepenseByCategory(utilisateur.idUtilisateur) as Map<String, int>;
    super.initState();
  }

  Future<List<StatModel>> getCategories() async {
    final response =
        await depenseService.getDepenseByCategory(utilisateur.idUtilisateur);
    return response;
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
      case 'Autres':
        return const Color.fromARGB(255, 56, 196, 21);
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildLegend(List<StatModel> categories) {
    return categories.map((e) {
      return Row(
        children: [
          Container(
            width: 15,
            height: 15,
            color: _getColorFromCategory(e.titreCategorie ?? ""),
          ),
          const SizedBox(width: 20),
          Text(e.titreCategorie ?? ""),
        ],
      );
    }).toList();
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(
                                      width: 50,
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
                          ],
                        ),
                      ],
                    ),
                  ))),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              "LES DEPENSES PAR CATEGORIES",
              style: TextStyle(fontSize: 20),
            ),
          ),
          // const SizedBox(height: 2),
          SizedBox(
            height: 380,
            width: 300,
            child: FutureBuilder(
                future: _futureListDepense,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Pas de données !"),
                    );
                  }
                  categories = snapshot.data!;
                  return PieChart(
                    PieChartData(
                      sections: categories
                          .map((e) => PieChartSectionData(
                                value: double.tryParse(
                                        e.totalDepenses.toString()) ??
                                    0.0,
                                title: e.titreCategorie,
                                color: _getColorFromCategory(
                                    e.titreCategorie ?? ""),
                              ))
                          .toList(),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildLegend(categories),
          ),
        ],
      ),
    );
  }
}
