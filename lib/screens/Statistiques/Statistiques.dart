import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Statistiques extends StatelessWidget {
  const Statistiques({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top:150),
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
                                style: TextStyle(
                                  fontSize: 20
                                ),
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
          ),
        ),
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
