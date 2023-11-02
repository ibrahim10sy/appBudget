import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/budgetDetail.dart';
import 'package:ika_musaka/screens/categoriess.dart';
import 'package:ika_musaka/screens/modifyBudget.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/Budget.dart';
import 'AjouterBudget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class BudgetListe extends StatefulWidget {
  const BudgetListe({super.key});

  @override
  _BudgetListeState createState() => _BudgetListeState();
}

class _BudgetListeState extends State<BudgetListe> {
  late Future<Map<String, dynamic>> future;
  late Future<List<Budget>> _futureListBudget;
  late List<Budget>? budgets = [];
  TextEditingController inputController = TextEditingController();
  late Utilisateur utilisateur;
  int? catValue;
  late Categorie maCat;
  late Future _mesCategories;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future fetchAlbum() async {
    final response =
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
//  Future catByUser(int id) async {
//     final response =
//         await http.get(Uri.parse('$apiUrl2/$id'));
//  //print(response);

//     if (response.statusCode == 200) {
//       print("Bienvenu au categorie");
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       print(jsonDecode(response.body));
//       return jsonDecode(response.body);
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to lire');
//     }
//   }

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

    // utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
    fetchAlbum();
    _mesCategories = http.get(Uri.parse(
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
                        const Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.attach_money_sharp,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
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
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const AjouterBudget()));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2,
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      23)),
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.add_circle,
                                                              color:
                                                                  Colors.white),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3.0),
                                                            child: Text(
                                                              "Ajouter budget",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
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
                                Image.asset("assets/images/budget.png",
                                    width: 39, height: 39),
                                const Expanded(
                                  //flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Liste des budgets :",
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
                          Expanded(child: rechercheEtTrier())
                        ],
                      ),
                    ),
                    const Divider(
                      height: 15,
                      color: Colors.white,
                    ),
                    Consumer<BudgetService>(
                        builder: (context, budgetService, child) {
                      if (budgetService.lastAction != budgetService.action) {
                        return FutureBuilder<List<Budget>>(
                            future: budgetService.action == "all"
                                ? budgetService.getBudgetByIdUser(
                                    "list/${utilisateur.idUtilisateur}")
                                : budgetService.action == "search"
                                    ? budgetService.searchBudgetByDesc(
                                        utilisateur.idUtilisateur)
                                    : budgetService.sortByMonthAndYear(
                                        utilisateur.idUtilisateur),
                            builder: (context, snapshot) {
                              //budgetService.action="all";

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.hasError) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Provider.of<BudgetService>(context,
                                          listen: false)
                                      .lastAction = budgetService.action;
                                  setState(() {});
                                });
                                return Center(
                                  child: Text(snapshot.error
                                      .toString()
                                      .replaceAll("Exception:", "")),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                    child: Text(
                                  "Aucune donnée trouvée !",
                                ));
                              }

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Provider.of<BudgetService>(context,
                                        listen: false)
                                    .lastAction = budgetService.action;
                                setState(() {});
                              });

                              budgets = snapshot.data;
                              return Expanded(
                                child: ListView.builder(
                                    itemCount: budgets!.length,
                                    itemBuilder: (context, index) {
                                      return createCardBudget(
                                          budgets![index].description!,
                                          index,
                                          budgets![index]);
                                    }),
                              );
                            });
                      } else {
                        Provider.of<BudgetService>(context, listen: false)
                            .lastAction = "";
                        if (budgetService.budgets.isNotEmpty) {
                          budgets = budgetService.budgets;
                          return Expanded(
                            child: ListView.builder(
                                itemCount: budgets!.length,
                                itemBuilder: (context, index) {
                                  return createCardBudget(
                                      budgets![index].description!,
                                      index,
                                      budgets![index]);
                                }),
                          );
                        } else {
                          return const Center(
                            child: Text("Aucun budget trouvé"),
                          );
                        }
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }

  //Card pour la liste des budget
  createCardBudget(String titre, int index, Budget budget) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BudgetDetaille(budget: budget)));
      },
      child: Container(
        margin: index == 0
            ? const EdgeInsets.only(bottom: 15, top: 15)
            : const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 6,
                  color: Color.fromRGBO(0, 0, 0, 0.25)),
            ],
            borderRadius: BorderRadius.circular(17)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/budget.png",
                        width: 33, height: 33),
                    Expanded(
                        child: Text(titre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible))
                  ],
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        debugPrint(budget.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ModifyBudget(budget: budget))));
                      },
                      icon: Image.asset("assets/images/edit_icon (2).png")),
                  IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10, bottom: 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              "assets/images/budget.png",
                                              width: 53,
                                              height: 53),
                                          const Expanded(
                                            child: Text(
                                              "Voulez-vous vraiment supprimer cet budget ?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      47, 144, 98, 1)),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(titre,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible),
                                      const Divider(
                                        color: Colors.white,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<BudgetService>(
                                                        context,
                                                        listen: false)
                                                    .deleteBudgetById(
                                                        "supprimer/${budget.idBudget}");
                                                Navigator.pop(context);
                                              },
                                              child: Flexible(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  color: Colors.red,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 30),
                                                    child: Text(
                                                      "OUI",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Flexible(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    color: const Color.fromRGBO(
                                                        47, 144, 98, 1),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 30),
                                                      child: Text(
                                                        "NON",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )))),
                      icon: Image.asset("assets/images/icon_poubelle.png"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Widget recherche et trier

  rechercheEtTrier() {
    final formKey = GlobalKey<FormState>();
    String description = "";

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Provider.of<BudgetService>(context, listen: false).action = "all";
              Provider.of<BudgetService>(context, listen: false).applyChange();
            },
            icon: const Icon(Icons.restart_alt,
                color: Color.fromRGBO(47, 144, 98, 1), size: 28)),
        IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32.0),
                                    topRight: Radius.circular(32.0)),
                                color: Color.fromRGBO(47, 144, 98, 1)),
                            child: Row(
                              children: [
                                Image.asset("assets/images/budget.png",
                                    width: 53, height: 53),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Rechercher un budget",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    margin: const EdgeInsets.only(bottom: 15.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 8.0,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Form(
                                          key: formKey,
                                          child: Expanded(
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Veuillez saisir une description";
                                                }
                                                description = value;
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: IconButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                Provider.of<BudgetService>(
                                                        context,
                                                        listen: false)
                                                    .applySearch(description);
                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: Image.asset(
                                                "assets/images/icon_search.png",
                                                width: 28,
                                                height: 28),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Flexible(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              color: Colors.red,
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 30),
                                                child: Text(
                                                  "FERMER",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )))
                                ],
                              ))
                        ],
                      ),
                    )),
            icon: Image.asset("assets/images/icon_search.png",
                width: 20, height: 20)),
        IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32.0),
                                    topRight: Radius.circular(32.0)),
                                color: Color.fromRGBO(47, 144, 98, 1)),
                            child: Row(
                              children: [
                                Image.asset("assets/images/budget.png",
                                    width: 53, height: 53),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Trier par mois et année",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(32.0),
                                    bottomRight: Radius.circular(32.0)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    margin: const EdgeInsets.only(bottom: 15.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 8.0,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          controller: inputController,
                                          readOnly: true,
                                        )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: IconButton(
                                              onPressed: () =>
                                                  _selectDate(context),
                                              icon: const Icon(
                                                  Icons.calendar_month,
                                                  color: Color.fromRGBO(
                                                      47, 144, 98, 1),
                                                  size: 30)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Provider.of<BudgetService>(context,
                                                    listen: false)
                                                .applyTrie(
                                                    inputController.text);
                                            Navigator.pop(context);
                                          },
                                          child: Flexible(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              color: const Color.fromRGBO(
                                                  47, 144, 98, 1),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 30),
                                                child: Text(
                                                  "TRIER",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ))),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Flexible(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              color: Colors.red,
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 30),
                                                child: Text(
                                                  "FERMER",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )))
                                ],
                              ))
                        ],
                      ),
                    )),
            icon: Image.asset("assets/images/icon_trie.png",
                width: 21, height: 17))
      ],
    );
  }
}
