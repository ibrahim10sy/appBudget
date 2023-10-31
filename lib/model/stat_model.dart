// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatModel {
  int? totalDepenses;
  String? titreCategorie;
  int? idCategorie;
  int? idDepenses;
  int? idUtilisateur;
  StatModel({
    this.totalDepenses,
    this.titreCategorie,
    this.idCategorie,
    this.idDepenses,
    this.idUtilisateur,
  });

  StatModel copyWith({
    int? totalDepenses,
    String? titreCategorie,
    int? idCategorie,
    int? idDepenses,
    int? idUtilisateur,
  }) {
    return StatModel(
      totalDepenses: totalDepenses ?? this.totalDepenses,
      titreCategorie: titreCategorie ?? this.titreCategorie,
      idCategorie: idCategorie ?? this.idCategorie,
      idDepenses: idDepenses ?? this.idDepenses,
      idUtilisateur: idUtilisateur ?? this.idUtilisateur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_depenses': totalDepenses,
      'titre_categorie': titreCategorie,
      'id_categorie': idCategorie,
      'id_depenses': idDepenses,
      'utilisateur_id_utilisateur': idUtilisateur,
    };
  }

  factory StatModel.fromMap(Map<String, dynamic> map) {
    return StatModel(
      totalDepenses:
          map['total_depenses'] != null ? map['total_depenses'] as int : null,
      titreCategorie: map['titre_categorie'] != null
          ? map['titre_categorie'] as String
          : null,
      idCategorie:
          map['id_categorie'] != null ? map['id_categorie'] as int : null,
      idDepenses: map['id_depenses'] != null ? map['id_depenses'] as int : null,
      idUtilisateur: map['utilisateur_id_utilisateur'] != null
          ? map['utilisateur_id_utilisateur'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatModel.fromJson(String source) =>
      StatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatModel(totalDepenses: $totalDepenses, titreCategorie: $titreCategorie, idCategorie: $idCategorie, idDepenses: $idDepenses, idUtilisateur: $idUtilisateur)';
  }

  @override
  bool operator ==(covariant StatModel other) {
    if (identical(this, other)) return true;

    return other.totalDepenses == totalDepenses &&
        other.titreCategorie == titreCategorie &&
        other.idCategorie == idCategorie &&
        other.idDepenses == idDepenses &&
        other.idUtilisateur == idUtilisateur;
  }

  @override
  int get hashCode {
    return totalDepenses.hashCode ^
        titreCategorie.hashCode ^
        idCategorie.hashCode ^
        idDepenses.hashCode ^
        idUtilisateur.hashCode;
  }
}
