import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/Pages/bar%20graph/BarGraphique.dart';

class Statistiques extends StatefulWidget {
  const Statistiques({super.key});
  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  List<double> Depense=[
    20.0,
    40.4,
    50.7,
    12,
    75,
    10,
    78,
    98,
    67,
    45,
    58,
    32
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          child: SizedBox(child: Graphique(
              Depense: Depense,
          )),
        ),
      ),
    );
  }
}
