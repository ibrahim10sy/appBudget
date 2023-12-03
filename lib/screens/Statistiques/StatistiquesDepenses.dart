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

class _StatistiquesDepensesState extends State<StatistiquesDepenses>
    with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> future;
  List<StatModel> categories = [];
  late Future<List<StatModel>> _futureListDepense;
  List<DepenseClass> depenses = [];
  late Utilisateur utilisateur;
  var depenseService = DepenseService();
  late AnimationController _animationController;

  @override
  void initState() {
    // future =
    //     BudgetService().getBudgetTotal("somme/${utilisateur.idUtilisateur}");

    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    _futureListDepense = getCategories();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      case 'Nourritures':
        return Colors.grey;
      case 'Courses':
        return const Color.fromARGB(141, 143, 77, 77);
      case 'Loyer':
        return Colors.blue;
      case 'Loisir':
        return const Color.fromRGBO(233, 30, 99, 1);
      case 'Loisirs':
        return Colors.pink;
      case 'Transport':
        return Colors.amberAccent;
      case 'Transports':
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
          const SizedBox(width: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<UtilisateurProvider>(
                          builder: (context, utilisateurProvider, child) {
                            final utilisateur = utilisateurProvider.utilisateur;
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
                                        backgroundImage:
                                            NetworkImage(utilisateur!.photos!),
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
                  ))),
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
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    // Amélioration du style du titre avec des animations
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 500),
                      tween: ColorTween(
                        begin: Colors.black,
                        end: const Color.fromRGBO(47, 144, 98, 1),
                      ),
                      builder: (context, dynamic color, child) {
                        return Text(
                          "LES DÉPENSES PAR CATÉGORIES",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
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
                    child: Text("Aucune statistique disponible !"),
                  );
                }

                categories = snapshot.data!;

                // Amélioration du conteneur du graphique avec des ombres, des bordures arrondies et des animations
                return (categories.isEmpty)
                    ? Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: 800,
                        // height: 900,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 290,
                                    child: Stack(
                                      children: [
                                        PieChart(
                                          PieChartData(
                                            startDegreeOffset: 90,
                                            sectionsSpace: 0.5,
                                            centerSpaceRadius: 100,
                                            sections: [
                                              PieChartSectionData(
                                                value: 40,
                                                color: Colors.grey,
                                                radius: 55,
                                                showTitle: false,
                                              ),
                                              PieChartSectionData(
                                                value: 35,
                                                color: Colors.blue,
                                                radius: 55,
                                                showTitle: false,
                                              ),
                                              PieChartSectionData(
                                                value: 35,
                                                color: Colors.amberAccent,
                                                radius: 55,
                                                showTitle: false,
                                              ),
                                              PieChartSectionData(
                                                value: 8,
                                                color: Colors.pink,
                                                radius: 55,
                                                showTitle: false,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 160,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade200,
                                                      blurRadius: 10.0,
                                                      spreadRadius: 10.0,
                                                      offset: const Offset(
                                                          3.0, 3.0),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildLegendItem("Nourriture", Colors.grey),
                                    _buildLegendItem("Loyer", Colors.blue),
                                    _buildLegendItem("Loisir", Colors.pink),
                                    _buildLegendItem(
                                        "Transport", Colors.amberAccent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(16.0),

                        // margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 400,
                        width: 300,
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Text("Statistique"),
                                  PieChart(
                                    swapAnimationDuration:
                                        const Duration(milliseconds: 750),
                                    swapAnimationCurve: Curves.easeInOutQuint,
                                    PieChartData(
                                      sections: categories.map((e) {
                                        // Calculer le pourcentage
                                        double percentage = (double.tryParse(e
                                                    .totalDepenses
                                                    .toString()) ??
                                                0.0) /
                                            categories.fold(
                                                0,
                                                (previous, current) =>
                                                    previous +
                                                    (double.tryParse(current
                                                            .totalDepenses
                                                            .toString()) ??
                                                        0.0));

                                        // Formater le pourcentage en pourcentage avec une décimale
                                        String percentageString =
                                            '${(percentage * 100).toStringAsFixed(1)}%';

                                        return PieChartSectionData(
                                          value: double.tryParse(
                                                  e.totalDepenses.toString()) ??
                                              0.0,
                                          title: percentageString,
                                          color: _getColorFromCategory(
                                              e.titreCategorie ?? ""),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildLegend(
                                  categories), // Assuming `categories` is accessible here
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
          margin: const EdgeInsets.only(right: 5),
        ),
        Text(label),
      ],
    );
  }
}
