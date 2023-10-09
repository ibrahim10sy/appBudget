// ignore: unused_import
import 'dart:convert';

import 'package:ika_musaka/screens/categorie.dart';
// import 'dart:ffi';

Budget budgetJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
   int? id;
  final String description;
  final int montant;
  final int montantAlert;
  final Categorie categorie;
  final String dateDebut;


  Budget({
    this.id,
    required this.description,
    required this.montant,
    required this.montantAlert,
    required this.categorie,
    required this.dateDebut,
  });
  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
      description: json["description"],
      montant: json["montant"],
      montantAlert: json["montantAlert"],
      categorie: json["categorie"],
      dateDebut: json["dateDebut"],
      id: json["idBudget"] ?? 0);

  Map<String, dynamic> toJson() => {
        "description": description,
        "montant": montant,
        "montantAlert": montantAlert,
        "categorie": categorie,
        "dateDebut": dateDebut,
        "idBudget": id
      };
  String get getDescription => description;
 int get getMontant => montant;
  int get getMontantAlert => montantAlert;
  String get getDatedebut => dateDebut;
  Categorie get getCategorie => categorie;
  int get getId => id ?? 0;
}
