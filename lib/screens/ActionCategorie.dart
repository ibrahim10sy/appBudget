// import 'dart:ffi';

import 'package:flutter/material.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class DialogHelper {
  static void showModifyCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31),
        ),
        titlePadding: EdgeInsets.only(top: 0, left: 0),
        title: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 8, left: 8),
                child: Image(
                  image: AssetImage('images/img.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, right: 7),
                child: Icon(
                  Icons.edit_sharp,
                  color: Color(0xFF2F9062),
                ),
              ),
              Text(
                'Modifier la Catégorie',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F9062),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nom de la catégorie',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ma_Categorie',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        // Votre logique lorsque le bouton est pressé
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        backgroundColor: const Color(0xFF2F9062),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        // Votre logique lorsque le bouton d'annulation est pressé
                        Navigator.of(context)
                            .pop(); // Ferme la boîte de dialogue
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        backgroundColor: Color.fromARGB(
                            255, 230, 10, 10), // Couleur du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Annuler",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showDeleteCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: EdgeInsets.only(top: 0, left: 0),
        title: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 8, left: 10),
                child: Image(
                  image: AssetImage('images/img.png'),
                ),
              ),
              Center(
                child: Text(
                  'Voulez-vous supprimer cette catégorie ?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F9062),
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nom de la catégorie',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Votre logique lorsque le bouton "NON" est pressé
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      backgroundColor: Color.fromARGB(
                          255, 230, 10, 10), // Couleur du bouton "NON"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    child: const Text(
                      "NON",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 40, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Votre logique lorsque le bouton "OUI" est pressé
                      // Ajoutez ici la logique pour supprimer la catégorie
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      backgroundColor:
                          const Color(0xFF2F9062), // Couleur du bouton "OUI"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    child: const Text(
                      "OUI",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ActionCategory extends StatefulWidget {
  const ActionCategory({Key? key}) : super(key: key);

  @override
  State<ActionCategory> createState() => _ActionCategoryState();
}

class _ActionCategoryState extends State<ActionCategory> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
