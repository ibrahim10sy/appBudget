// ignore: unused_import
import 'dart:convert';
// import 'dart:ffi';

Budget budgetJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
  final int id;
  final String description;
  final int montant;
  final int montantAlert;
  final DateTime datedebut;
  final String categorie;

  Budget({
    required this.description,
    required this.montant,
    required this.montantAlert,
    required this.datedebut,
    required this.categorie,
    required this.id, required montantAlerte,
  });
  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
      description: json["description"],
      montant: json["montant"],
      montantAlert: json["montantAlert"],
      datedebut: json["datedebut"],
      categorie: json["categorie"],
      id: json["id"], montantAlerte: null);

  Map<String, dynamic> toJson() => {
        "description": description,
        "montant": montant,
        "montantAlert": montantAlert,
        "datedebut": datedebut,
        "categorie": categorie,
        "id": id
      };
  String get getDescription => description;
  int get getMontant => montant;
  int get getMontantAlert => montantAlert;
  DateTime get getDatedebut => datedebut;
  String get getCategorie => categorie;
  int get getId => id;
}
