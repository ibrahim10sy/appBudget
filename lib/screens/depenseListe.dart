import 'package:flutter/material.dart';

class DepenseListe extends StatefulWidget {
  const DepenseListe({super.key});

  @override
  State<DepenseListe> createState() => _DepenseListeState();
}

class _DepenseListeState extends State<DepenseListe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste'),
      ),
    );
  }
}