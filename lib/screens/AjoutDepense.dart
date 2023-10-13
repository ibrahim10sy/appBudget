import 'package:flutter/material.dart';
import '../services/DepenseService.dart'; 

class AjoutDepense extends StatefulWidget {
  const AjoutDepense({super.key});

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<AjoutDepense> {
  DateTime selectedDate = DateTime.now();
  String? selectedType;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController montantController = TextEditingController();

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
      await DepenseService.ajouterDepense(
        description: descriptionController.text,
        montant: double.parse(montantController.text),
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
               Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/photoprofil.png'),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Name User",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: 372,
                height: 480,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Description des dépenses",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(47, 144, 98, 1),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: descriptionController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/share.png',
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Montant",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(47, 144, 98, 1),
                              ),
                            ),

                            Expanded(
                              child: TextField(
                                controller: montantController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/programme.png',
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Type",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(47, 144, 98, 1),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors
                                        .white // Même couleur que les autres champs
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedType = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Option 1',
                                      'Option 2',
                                      'Option 3',
                                      'Option 4'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    dropdownColor: Colors
                                        .white, // Même couleur que les autres champs
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ),

                            
                          ],
                        ),
                        SizedBox(width: 10),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           Image.asset(
                              'assets/images/calendar.png',
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(47, 144, 98, 1),
                              ),
                            ),

                            Expanded(
                              child: TextButton(
                                onPressed: () => _selectDate(context),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${selectedDate.toLocal()}"
                                            .split(' ')[0],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ),
                            
                          ],
                        ),
                        SizedBox(width: 10),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Color.fromRGBO(47, 144, 98, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); 
                          },
                          child: const Text(
                            "Annuler",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

