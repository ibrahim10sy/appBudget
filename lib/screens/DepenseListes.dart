import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';

class DepensesListes extends StatefulWidget {
  const DepensesListes({Key? key}) : super(key: key);

  @override
  _DepenseState createState() => _DepenseState();
}

class _DepenseState extends State<DepensesListes> {
  late Future<List<Map<String, dynamic>>> depenses;
  late Utilisateur utilisateur;

  @override
  void initState() {
    super.initState();
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    depenses = fetchDepenses();
  }

  Future<List<Map<String, dynamic>>> fetchDepenses() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/Depenses/${utilisateur.idUtilisateur}/read'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: depenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 30, right: 15.0, bottom: 15.0),
                      child: Container(
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
                                  builder:
                                      (context, utilisateurProvider, child) {
                                    final utilisateur =
                                        utilisateurProvider.utilisateur;
                                    return Row(
                                      children: [
                                        utilisateur?.photos == null ||
                                                utilisateur?.photos?.isEmpty ==
                                                    true
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        240, 176, 2, 1),
                                                radius: 30,
                                                child: Text(
                                                  "${utilisateur!.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          ))),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 10, left: 10, bottom: 10, top: 50),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(47, 144, 98, 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Budget Total:',
                                style: TextStyle(
                                    fontSize: 29.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 50),
                              OutlinedButton(
                                onPressed: () {
                                  // Action à effectuer lorsqu'on appuie sur le bouton
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Text(
                                  "+ Ajouter Dépenses",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 40,
                        child: Image.asset(
                          'assets/images/wallet.png',
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 372,
                    height: 457,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/wallet.png"),
                                ),
                                title: Text("Liste des depenses",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(47, 144, 98, 1),
                                    ))),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final depense = snapshot.data![index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white10, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Image.asset(
                                            "assets/images/wallet.png"),
                                      ),
                                      title: Text(depense['description']),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
