

class Budget {
  int? idBudget;
  String? description;
  int? montant;
  int? montantRestant;
  int? montantAlert;
  String? dateDebut;
  String? dateFin;
  //Utilisateur? utilisateur;
  Map<String,dynamic>? categorie;

  Map<String, dynamic> toMap(){
    return{
      "idBudget":idBudget,
      "description" :description,
      "montant" : montant,
      "montantRestant":montantRestant,
      "montantAlert":montantAlert,
      "dateDebut": dateDebut,
      "dateFin":dateFin,
    };
  }
  Budget({this.idBudget,this.description,this.montant,this.montantRestant,this.montantAlert,this.dateDebut,this.dateFin
  ,this.categorie});

  factory Budget.fromJson(Map<String,dynamic> json){
    return Budget(idBudget: json["idBudget"],description: json["description"],montant: json["montant"],montantRestant: json["montantRestant"],
    montantAlert: json["montantAlerte"], dateDebut: json["dateDebut"],dateFin: json["dateFin"],categorie: json["categorie"]);
  }
}