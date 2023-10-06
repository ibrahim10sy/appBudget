import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ika_musaka/screens/Pages/bar%20graph/BarDonnee.dart';

class Graphique extends StatelessWidget {
  final List Depense;
  const Graphique(
      {
        super.key,
        required this.Depense,
      }
  );

  @override
  Widget build(BuildContext context) {
    BarDonnee BarreDonnee = BarDonnee(
        Janvier: Depense[0],
        Fevrier: Depense[1],
        Mars: Depense[2],
        Avril:Depense[3],
        Mai: Depense[4],
        Juin: Depense[5],
        Juillet: Depense[6],
        Aout:Depense[7],
        Septembre: Depense[8],
        Octobre: Depense[9],
        Novembre: Depense[10],
        Decembre: Depense[11]
    );
    BarreDonnee.initializeBarDonnee();
    return BarChart(
      BarChartData(
        maxY:400,
        minY:0,
        barGroups: BarreDonnee.barDonnee.map((data) => BarChartGroupData(
          x:data.x,
        barRods: [BarChartRodData(toY:data.y)]
        )
        ).toList(),
      )
    );
  }
}
