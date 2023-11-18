import 'package:ika_musaka/model/utilisateur.dart';

class Budget {
  int? idBudget;
  String? description;
  int? montant;
  int? montantRestant;
  int? montantAlerte;
  String? dateDebut;
  String? dateFin;
  Utilisateur? utilisateur;
  Map<String, dynamic>? categorie;

  Map<String, dynamic> toMap() {
    return {
      "idBudget": idBudget,
      "description": description,
      "montant": montant,
      "montantRestant": montantRestant,
      "montantAlerte": montantAlerte,
      "dateDebut": dateDebut,
      "dateFin": dateFin,
      'utilisateur': utilisateur,
      'categorie':categorie,
    };
  }

  Budget(
      {this.idBudget,
      this.description,
      this.montant,
      this.montantRestant,
      this.montantAlerte,
      this.dateDebut,
      this.dateFin,
      this.categorie});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
        idBudget: json["idBudget"],
        description: json["description"],
        montant: json["montant"],
        montantRestant: json["montantRestant"],
        montantAlerte: json["montantAlerte"],
        dateDebut: json["dateDebut"],
        dateFin: json["dateFin"],
        categorie: json["categorie"]);
  }
}
