import 'dart:collection';

class Budget {
  int? idBudget;
  String? description;
  int? montant;
  int? montantRestant;
  int? montantAlert;
  String? dateDebut;
  String? dateFin;
  Map<String,dynamic>? utilisateur;
  Map<String,dynamic>? categorie;

  Budget({this.idBudget,this.description,this.montant,this.montantRestant,this.montantAlert,this.dateDebut,this.dateFin
  ,this.utilisateur,this.categorie});

  factory Budget.fromJson(Map<String,dynamic> json){
    return Budget(idBudget: json["idBudget"],description: json["description"],montant: json["montant"],montantRestant: json["montantRestant"],
    montantAlert: json["montantAlert"], dateDebut: json["dateDebut"],dateFin: json["dateFin"],utilisateur: json["utilisateur"],categorie: json["categorie"]);
  }
}