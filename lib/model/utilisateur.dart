
import 'dart:io';

// import 'dart:convert';
class Utilisateur {
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final int idUtilisateur;
  final String? photos;

  Utilisateur({required this.photos,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.idUtilisateur
    });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      motDePasse: json['motDePasse'],
      idUtilisateur: json['idUtilisateur'],
      photos: json['photos'],
    );
  }
}