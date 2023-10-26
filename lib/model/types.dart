import 'dart:convert';

class Types{
 int? idType;
 final String titre;

 Types({this.idType, required this.titre});

 factory Types.fromJson(Map<String, dynamic> json) =>
      Types(titre: json["titre"], idType: json["idType"] as int?);

  Map<String, dynamic> toJson() => {"titre": titre, "idType": idType};

   Map<String, dynamic> toMap(){
    return{
      "idType":idType,
      "titre":titre
    };
  }
  
  factory Types.fromMap(Map<String, dynamic> map){
    return Types(titre: map['titre'], idType: map['idType']);
  }
  String get getTitre => titre;
  int get getId => idType ?? 0;
}