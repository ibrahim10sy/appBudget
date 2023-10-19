// class Depense {
//   String description;
//   double montant;
//   String type;
//   DateTime date;
//   int? idDepenses;

//   // Constructeur
//   Depense({
//     required this.description,
//     required this.montant,
//     required this.type,
//     required this.date,
//     required this.idDepenses

//   });

//   factory Depense.fromJson(Map<String, dynamic> json) {
//     return Depense(
//       description: json['description'],
//       montant: json['montant'],
//       type: json['type'],
//       date: json['date'],
//       idDepenses: json['idDepenses'],
     
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/model/Budget.dart';

class Depense {
  final  int? idDepenses;
  final String description;
  final  int montant;
  final  String date;
  final  Budget budget;
  final  String type;

    Depense({
        required this.idDepenses,
        required this.description,
        required this.montant,
        required this.date,
        required this.budget,
        required this.type,
    });

    factory Depense.fromJson(Map<String, dynamic> json) => Depense(
        idDepenses: json["idDepenses"],
        description: json["description"],
        montant: json["montant"],
        date: json["date"],
        budget: Budget.fromJson(json["budget"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "idDepenses": idDepenses,
        "description": description,
        "montant": montant,
        "date": date,
        // "budget": budget.toJson(),
        "type": type ,
    };
}