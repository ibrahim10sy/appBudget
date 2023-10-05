// To parse this JSON data, do
//
//     final categorie = categorieFromMap(jsonString);

import 'dart:convert';

Categorie categorieFromJson(String str) => Categorie.fromJson(json.decode(str));

String categorieToJson(Categorie data) => json.encode(data.toJson());

class Categorie {
    int idCategorie;
    String titre;

    Categorie({
        required this.idCategorie,
        required this.titre,
    });

    factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
        idCategorie: json["idCategorie"],
        titre: json["titre"],
    );

    Map<String, dynamic> toJson() => {
        "idCategorie": idCategorie,
        "titre": titre,
    };
    int get getIdCategorie => idCategorie;
    String get getTitre=> titre;
 
}
