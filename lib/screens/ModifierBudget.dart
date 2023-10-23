import 'package:flutter/material.dart';

import '../services/depenseService.dart';

class AjoutDepense extends StatefulWidget {
  const AjoutDepense({super.key});

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<AjoutDepense> {
  DateTime selectedDate = DateTime.now();
  String? selectedType;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        )) ??
        selectedDate;

    if (picked != true && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _ajouterDepense() async {
    try {
      await DepenseService().ajouterDepense(
        description: "Description", 
        montant: 50.0,
        type: selectedType ?? "", 
        date: selectedDate, 
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dépense ajoutée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout de la dépense : $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color.fromRGBO(47, 144, 98, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: _ajouterDepense,
                child: const Text(
                  "Ajouter",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color.fromRGBO(228, 46, 46, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {},
                child: const Text(
                  "Annuler",
                  style: TextStyle(fontSize: 24),
                ),
              ),

              // ... Le reste de votre code
            ],
          ),
        ),
      ),
    );
  }
}
