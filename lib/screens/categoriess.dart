import 'dart:convert';


class Categorie{
  int? id;
  final String titre;
  Categorie({this.id, required this.titre});

  Map<String, dynamic> toMap(){
    return{
      "idCategorie":id,
      "titre":titre
    };
  }
  
  factory Categorie.fromMap(Map<String, dynamic> map){
    return Categorie(titre: map['titre'], id: map['idCategorie']);
  }

  String toJson() => json.encode(toMap());
  factory Categorie.fromJson(String value) => Categorie.fromMap(json.decode(value));
}