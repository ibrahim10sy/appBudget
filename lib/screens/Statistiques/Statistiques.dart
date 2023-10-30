import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../model/utilisateur.dart';
import '../../provider/UtilisateurProvider.dart';

class Statistiques extends StatelessWidget {
  const Statistiques({Key? key});

  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
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
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: badges.Badge(
                              position:
                                  badges.BadgePosition.topEnd(top: -2, end: -2),
                              badgeContent: const Text(
                                "3",
                                style: TextStyle(color: Colors.white),
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: Color.fromRGBO(240, 176, 2, 1),
                                size: 40,
                              ),
                            ))
                      ],
                    ),
                  ))),
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: 370,
            height: 500,
            decoration: ShapeDecoration(
              color: const Color(0xFFFFFBFB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x70000000),
                  blurRadius: 13,
                  offset: Offset(1, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: const Text(
                              "LES DEPENSES PAR CATEGORIES",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            height: 300,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 10.0,
                                              spreadRadius: 10.0,
                                              offset: const Offset(3.0, 3.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildLegendItem("Nourriture", Colors.grey),
                            _buildLegendItem("Loyer", Colors.blue),
                            _buildLegendItem("Loisir", Colors.pink),
                            _buildLegendItem("Transport", Colors.amberAccent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
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
