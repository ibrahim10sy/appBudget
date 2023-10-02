import 'dart:convert';
Utilisateur utilisateurJson(String str) =>
Utilisateur.fromJson(json.decode(str));

String utilisateurToJson(Utilisateur data) => json.encode(data.toJson());

class Utilisateur {
    String id;
   String nom;
   String prenom;
   String email;
   String motDepasse;

  Utilisateur({required this.nom,required this.prenom,required this.email,required this.motDepasse, required this.id});

  factory Utilisateur.fromJson(Map<String, dynamic> json)=> Utilisateur(
    nom: json["nom"],
    id: json["id"],
    prenom: json["prenom"],
    email: json["email"],
    motDepasse: json["motDepasse"]
  );

  Map<String, dynamic> toJson ()=> {
    "id": id,
    "nom": nom,
    "prenom": prenom,
    "email": email,
    "motDepasse": motDepasse
  };
  String get getId => id;
  String get getNom => nom;
  String get getPrenom => prenom;
  String get getEmail => email;
  String get getMotDepasse => motDepasse;
}