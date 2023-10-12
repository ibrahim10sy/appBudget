import 'package:ika_musaka/model/Budget.dart';
import 'package:ika_musaka/model/utilisateur.dart';

class DepenseClass{
  int? idDepense;
  String? description;
  int? montant;
  String? date;
  Budget? budget;
  Map<String, dynamic>? type;
  Utilisateur? utilisateur;

  DepenseClass({this.idDepense, this.description, this.montant, this.date,
      this.budget, this.type, this.utilisateur});

  factory DepenseClass.fromJson(Map<String, dynamic> json){
    return DepenseClass(
      idDepense: json["idDepenses"],
      description: json["description"],
      montant: json["montant"],
      date: json["date"],
      budget: Budget.fromJson(json["budget"]),
      type: json["type"],
      utilisateur: Utilisateur.fromJson(json["utilisateur"])
    );
  }
}