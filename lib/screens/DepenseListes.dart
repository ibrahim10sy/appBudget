import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/DepenceClasse.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:ika_musaka/services/depenseService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/Budget.dart';

class DepensesListes extends StatefulWidget {
  const DepensesListes({Key? key}) : super(key: key);

  @override
  _DepenseState createState() => _DepenseState();
}

class _DepenseState extends State<DepensesListes> {
  late Future<Map<String, dynamic>> future;
  late Future<List<Budget>> _futureListBudget;
  late List<Budget>? budgets = [];
  late Future<List<DepenseClass>> _futureListDepense;
  late List<DepenseClass>? depense = [];
  TextEditingController inputController = TextEditingController();
  late Utilisateur utilisateur;
  int? catValue;
  late Future _mesCategories;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future fetchAlbum() async {
    final response =
        // await http.get(Uri.parse('https://apibudget.onrender.com/Budget/list'));
        await http.get(Uri.parse('http://10.0.2.2:8080/Budget/list'));
//print(response);
    if (response.statusCode == 200) {
      print("Bienvenue dans le console");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('yyyy-MM').format(picked);
      setState(() {
        inputController.text = formattedDate;
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    future =
        BudgetService().getBudgetTotal("somme/${utilisateur.idUtilisateur}");
    _futureListBudget =
        BudgetService().getBudgetByIdUser("list/${utilisateur.idUtilisateur}");
    inputController.text = DateFormat('yyyy-MM').format(DateTime.now());
    _futureListDepense =
        DepenseService().depenseByIdUser(utilisateur.idUtilisateur);
    fetchAlbum();
    _mesCategories = http.get(Uri.parse(
        // 'https://apibudget.onrender.com/Categorie/list/${utilisateur.idUtilisateur}'));
        'http://10.0.2.2:8080/Categorie/list/${utilisateur.idUtilisateur}'));
    // utilisateur =
    //     Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
  }

  void updateOnCLick() {
    _futureListBudget =
        BudgetService().getBudgetByIdUser("list/${utilisateur.idUtilisateur}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                          child: Flexible(
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
                                    Consumer<BudgetService>(builder:
                                        (context, budgetService, child) {
                                      int montantTotal = 0;
                                      int montantRestant = 0;
                                      List<Budget> budgetList = context.select(
                                          (BudgetService value) =>
                                              value.budgets);
                                      if (budgetList.isNotEmpty) {
                                        for (var element in budgetList) {
                                          montantTotal =
                                              montantTotal + element.montant!;
                                          montantRestant = montantRestant +
                                              element.montantRestant!;
                                        }
                                      }
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("$montantTotal FCFA",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0,
                                                    bottom: 7.5,
                                                    top: 7.5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text("Restant :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17)),
                                                        Text(
                                                            "$montantRestant FCFA",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17))
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text("Dépensé :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17)),
                                                        Text(
                                                            "${montantTotal - montantRestant} FCFA",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Row(
                                                children: [],
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                  Image.asset(
                    "assets/images/budget.png",
                    width: 150,
                    height: 99,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                height: 445,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 13,
                          color: Color.fromRGBO(0, 0, 0, 0.25))
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            //flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/wallet-budget-icon.png",
                                  width: 40,
                                  height: 40,
                                ),
                                const Expanded(
                                  //flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Liste des depenses :",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(47, 144, 98, 1)),
                                      //overflow: TextOverflow.visible,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Provider.of<DepenseService>(context,
                                        listen: false)
                                    .action = "all";
                                Provider.of<DepenseService>(context,
                                        listen: false)
                                    .applyChange();
                              },
                              icon: const Icon(Icons.restart_alt,
                                  color: Color.fromRGBO(47, 144, 98, 1),
                                  size: 28)),
                        ],
                      ),
                    ),
                   Consumer<DepenseService>(
                      builder: (context, depenseService, child) {
                        depenseService.action = "all";
                        return Expanded(
                          child: FutureBuilder<List<DepenseClass>>(
                            future: depenseService
                                .depenseByIdUser(utilisateur
                                .idUtilisateur), 
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text("Aucune dépense trouvée"),
                                );
                              } else {
                                depense = snapshot.data!;

                                return ListView.builder(
                                  itemCount: depense!.length,
                                  itemBuilder: (context, index) {
                                    return createCardDepense(
                                      depense![index].description!,
                                      index,
                                      depense![index],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),

                    const Divider(
                      height: 15,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  //Card pour la liste des depenses
  createCardDepense(String titre, int index, DepenseClass depense) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage(
              "assets/images/wallet-budget-icon.png"), // Remplacez le chemin par le vôtre
        ),
        title: Text(
          depense.description ?? 'Aucune description disponible',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Ajoutez d'autres éléments ici comme le montant, la date, etc.
      ),
    );
  }
}

// restartDepense() {
//   final formKey = GlobalKey<FormState>();
//   String description = "";
//   return Container(
//     child :  IconButton(
//                               onPressed: () {
//                                 Provider.of<DepenseService>(context,
//                                         listen: false)
//                                     .action = "all";
//                                 Provider.of<DepenseService>(context,
//                                         listen: false)
//                                     .applyChange();
//                               },
//                               icon: const Icon(Icons.restart_alt,
//                                   color: Color.fromRGBO(47, 144, 98, 1),
//                                   size: 28)),
//   )
// }
