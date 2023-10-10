import 'dart:convert';

class CategorieM {
  int? id;
  final String titre;

  CategorieM({
    this.id,
    required this.titre,
  });

  factory CategorieM.fromJson(Map<String, dynamic> json) =>
    CategorieM(titre: json["titre"], id: json["idCategorie"] as int?);


  Map<String, dynamic> toJson() => {"titre": titre, "idCategorie": id};

  String get getTitre => titre;
  int get getId => id ?? 0;
}
