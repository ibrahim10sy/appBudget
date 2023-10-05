// To parse this JSON data, do
//
//     final categorie = categorieFromMap(jsonString);

import 'dart:convert';

// CategorieM categorieMFromJson(String str) => CategorieM.fromJson(json.decode(str));

// String categorieMToJson(CategorieM data) => json.encode(data.toJson());

class CategorieM {
  //  int idCategorie;
    String titre;

    CategorieM({
    //    required this.idCategorie,
        required this.titre,
    });

  factory CategorieM.fromJson(Map<String, dynamic> json) {
    return CategorieM(
      titre: json["titre"],
     );
  }
   
    String get getTitre=> titre;
 
}
