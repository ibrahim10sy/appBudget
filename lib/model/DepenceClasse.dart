import 'package:ika_musaka/model/Budget.dart';
import 'package:ika_musaka/model/utilisateur.dart';

class DepenseClass{
  int? idDepenses;
  String? description;
  int? montant;
  String? date;
  Budget? budget;
  Map<String, dynamic>? type;
  Utilisateur? utilisateur;

  DepenseClass({this.idDepenses, this.description, this.montant, this.date,
      this.budget, this.type, this.utilisateur});

  factory DepenseClass.fromJson(Map<String, dynamic> json){
    return DepenseClass(
      idDepenses: json["idDepenses"],
      description: json["description"],
      montant: json["montant"],
      date: json["date"],
      budget: Budget.fromJson(json["budget"]),
      type: json["type"],
      utilisateur: Utilisateur.fromJson(json["utilisateur"])
    );
  }
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDepenses': idDepenses,
      'description': description,
      'montant': montant,
      'date': date,
      'budget': budget?.toMap(),
      'type': type,
      'utilisateur': utilisateur?.toMap(),
    };
  }
}