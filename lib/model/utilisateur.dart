import 'dart:convert';
class Utilisateur {
  final String username;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final int idUtilisateur;

  Utilisateur({required this.username,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.idUtilisateur});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      username: json["username"],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      idUtilisateur: json['idUtilisateur'],
    );
  }
}