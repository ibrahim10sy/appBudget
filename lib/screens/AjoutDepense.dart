import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ika_musaka/model/Budget.dart';
import 'package:ika_musaka/model/types.dart';
import 'package:ika_musaka/screens/budgetDetail.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/DepenceClasse.dart';
import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';
import '../services/depenseService.dart';

class AjoutDepense extends StatefulWidget {
  const AjoutDepense({super.key, required this.budget});

  final Budget budget;

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<AjoutDepense> {
  DateTime selectedDate = DateTime.now();
  String? selectedType;
  // late Budget budget ;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController montant_control = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController datedeDepense_control = TextEditingController();
  int? typeValue;
  late Types maType;
  late Utilisateur utilisateur;
  late DepenseClass depenses;
  late Future _mesType;
  int budget = 0;

  @override
  void initState() {
    _mesType = http.get(Uri.parse('http://10.0.2.2:8080/Type/lire'));
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
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
                                const SizedBox(
                                  width: 50,
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
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 15),
                        //   child: badges.Badge(
                        //     position:
                        //         badges.BadgePosition.topEnd(top: -2, end: -2),
                        //     badgeContent: const Text(
                        //       "3",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     child: const Icon(
                        //       Icons.notifications,
                        //       color: Color.fromRGBO(240, 176, 2, 1),
                        //       size: 40,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ))),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 30),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(47, 144, 98, 1),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/wallet.png"),
                    const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Ajouter Dépense",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                      color: const Color(0xfff9f7f7),
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              'Description :',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2f9062)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 15),
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xfff9f7f7),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 7,
                                    color: Color.fromRGBO(0, 0, 0, 0.25))
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: TextField(
                                controller: descriptionController,
                                maxLines: 3,
                                decoration: const InputDecoration.collapsed(
                                    hintText:
                                        "Une description pour la dépense"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/share.png',
                                    width: 23,
                                  ),
                                  const Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Montant :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff2f9062)),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      controller: montant_control,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                          labelText: 'Montant',
                                          labelStyle:
                                              TextStyle(color: Colors.green),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 3,
                                                  color: Colors.green))),
                                    ),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/programme.png',
                                  width: 23,
                                ),
                                const Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "Types",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff2f9062)),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: FutureBuilder(
                                      future: _mesType,
                                      builder: (_, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return DropdownButton(
                                              dropdownColor: Colors.green,
                                              items: const [],
                                              onChanged: (value) {});
                                        }
                                        if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        if (snapshot.hasData) {
                                          //debugPrint(snapshot.data.body.toString());
                                          final reponse =
                                              json.decode(snapshot.data.body)
                                                  as List;
                                          final mesTypes = reponse
                                              .map((e) => Types.fromMap(e))
                                              .toList();
                                          //debugPrint(mesCategories.length.toString());
                                          return DropdownButton(
                                              items: mesTypes
                                                  .map((e) => DropdownMenuItem(
                                                        value: e.idType,
                                                        child: Text(e.titre),
                                                      ))
                                                  .toList(),
                                              value: typeValue,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  typeValue = newValue;
                                                  maType = mesTypes.firstWhere(
                                                      (element) =>
                                                          element.idType ==
                                                          newValue);
                                                  debugPrint(
                                                      maType.idType.toString());
                                                });
                                              });
                                        }
                                        return DropdownButton(
                                            items: const [],
                                            onChanged: (value) {});
                                      },
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/calendrier.png',
                                    width: 23,
                                  ),
                                  const Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Date début :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff2f9062)),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      controller: datedeDepense_control,
                                      decoration: const InputDecoration(
                                          labelText: 'Date de création',
                                          labelStyle:
                                              TextStyle(color: Colors.green),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 3,
                                                  color: Colors.green))),
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2100));
                                        if (pickedDate != null) {
                                          print(pickedDate);
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          print(formattedDate);
                                          setState(() {
                                            datedeDepense_control.text =
                                                formattedDate;
                                          });
                                        } else {}
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                  ),
                                  onPressed: () async {
                                    final descriptions =
                                        descriptionController.text;
                                    final montants = montant_control.text;
                                    int? mt;
                                    final dateDepenses =
                                        datedeDepense_control.text;
                                    final budgets = widget.budget;

                                    // Validation pour s'assurer que montants est un nombre valide
                                    if (montants.isEmpty ||
                                        descriptions.isEmpty ||
                                        dateDepenses.isEmpty) {
                                      const String errorMessage =
                                          "Tous les champs doivent être remplis";
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(
                                                child: Text('Erreur')),
                                            content: const Text(errorMessage),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      try {
                                        // Convertir la saisie en un nombre
                                        mt = int.tryParse(montants);

                                        if (mt == null) {
                                          // La saisie n'est pas un nombre valide
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Center(
                                                    child: Text(
                                                        'Erreur de format')),
                                                content: const Text(
                                                    "Le montant doit être un nombre valide."),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (mt >
                                            widget.budget.montantRestant!) {
                                          // Le montant de la dépense dépasse le montant du budget
                                          const String errorMessage =
                                              "Le montant de la dépense ne doit pas dépasser celui du budget";
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Center(
                                                    child: Text('Erreur')),
                                                content:
                                                    const Text(errorMessage),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          // Le montant est valide et ne dépasse pas le budget, ajouter la dépense.
                                          await Provider.of<DepenseService>(
                                                  context,
                                                  listen: false)
                                              .ajouterDepense(
                                            description: descriptions,
                                            montant: montants,
                                            type: maType,
                                            dateDepense: dateDepenses,
                                            budget: budgets,
                                            utilisateur: utilisateur,
                                          );

                                          Provider.of<BudgetService>(context,
                                                  listen: false)
                                              .applyChange();

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Center(
                                                    child: Text('Succès')),
                                                content: const Text(
                                                    "Dépense ajoutée avec succès"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  )
                                                ],
                                              );
                                            },
                                          );

                                          descriptionController.clear();
                                          montant_control.clear();
                                          typeController.clear();
                                          datedeDepense_control.clear();
                                        }
                                      } catch (e) {
                                        final String errorMessage =
                                            e.toString();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Center(
                                                  child: Text('Erreur')),
                                              content: Text(
                                                  errorMessage.replaceAll(
                                                      "Exception:", "")),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }

                                    // onPressed: () async {
                                    //   final descriptions = descriptionController.text;
                                    //   final montants = montant_control.text;
                                    //   int mt ;
                                    //   final dateDepenses = datedeDepense_control.text;
                                    //   final budgets = widget.budget;
                                    //   // Validation pour s'assurer que montants est un nombre valide
                                    //   if (montants.isEmpty || descriptions.isEmpty || dateDepenses.isEmpty) {
                                    //   final String errorMessage = "Tous les champs doivent être remplis";
                                    //      showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         title: Center(child: Text('Erreur')),
                                    //         content: Text(errorMessage),
                                    //         actions: <Widget>[
                                    //           TextButton(
                                    //             onPressed: () {
                                    //               Navigator.of(context).pop();
                                    //             },
                                    //             child: Text('OK'),
                                    //           )
                                    //         ],
                                    //       );
                                    //     },
                                    //   );
                                    //   if(depenses.montant! > widget.budget.montant!){
                                    //     final String errorMessage = "Le montant du depense ne doit pas surpasse celle du budget";
                                    //      showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         title: Center(child: Text('Erreur')),
                                    //         content: Text(errorMessage),
                                    //         actions: <Widget>[
                                    //           TextButton(
                                    //             onPressed: () {
                                    //               Navigator.of(context).pop();
                                    //             },
                                    //             child: Text('OK'),
                                    //           )
                                    //         ],
                                    //       );
                                    //     },
                                    //   );
                                    //   }else{
                                    //    try{
                                    //             await DepenseService.ajouterDepense(
                                    //                 description: descriptions,
                                    //                 montant : montants,
                                    //                 type : maType,
                                    //                 dateDepense : dateDepenses,
                                    //                 budget : budgets,
                                    //                 utilisateur : utilisateur,
                                    //             );
                                    //  Provider.of<DepenseService>(context, listen: false).applyChange();

                                    //    showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         title: Center(child: Text('Succès')),
                                    //         content: Text("Depense ajouté avec succès"),
                                    //         actions: <Widget>[
                                    //           TextButton(
                                    //             onPressed: () {
                                    //               Navigator.of(context).pop(context);
                                    //             },
                                    //             child: Text('OK'),
                                    //           )
                                    //         ],
                                    //       );
                                    //     },
                                    //   );
                                    //   descriptionController.clear();
                                    //   montant_control.clear();
                                    //   typeController.clear();
                                    //   datedeDepense_control.clear();

                                    //     } catch (e) {
                                    //       final String errorMessage = e.toString();
                                    //       showDialog(
                                    //         context: context,
                                    //         builder: (BuildContext context) {
                                    //           return AlertDialog(
                                    //             title: Center(child: Text('Erreur')),
                                    //             content: Text(errorMessage.replaceAll("Exception:", "")),
                                    //             actions: <Widget>[
                                    //               TextButton(
                                    //                 onPressed: () {
                                    //                   Navigator.of(context).pop();
                                    //                 },
                                    //                 child: Text('OK'),
                                    //               ),
                                    //             ],
                                    //           );
                                    //         },
                                    //       );
                                    //     }
                                    //     }
                                    //   } else{
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //           title: Center(child: Text('Erreur de format')),
                                    //           content: Text("Le montant doit être un nombre valide."),
                                    //           actions: <Widget>[
                                    //             TextButton(
                                    //               onPressed: () {
                                    //                 Navigator.of(context).pop();
                                    //               },
                                    //               child: Text('OK'),
                                    //             ),
                                    //           ],
                                    //         );
                                    //       },
                                    //     );
                                    //   }
                                  },
                                  child: const Text(
                                    'Ajouter',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              228, 46, 46, 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13))),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    BudgetDetaille(
                                                      budget: widget.budget,
                                                    ))));
                                      },
                                      child: const Text(
                                        'Annuler',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
