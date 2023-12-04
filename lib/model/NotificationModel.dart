import 'dart:convert';

import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/model/Budget.dart';

class NotificationModel {
  int idNotification;
  String texte;
  String date;
  Utilisateur utilisateur;
  Budget budget;

  NotificationModel({
    required this.idNotification,
    required this.texte,
    required this.date,
    required this.utilisateur,
    required this.budget,
  });

  NotificationModel copyWith({
    int? idNotification,
    String? texte,
    String? date,
    Utilisateur? utilisateur,
    Budget? budget,
  }) {
    return NotificationModel(
      idNotification: idNotification ?? this.idNotification,
      texte: texte ?? this.texte,
      date: date ?? this.date,
      utilisateur: utilisateur ?? this.utilisateur,
      budget: budget ?? this.budget,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idNotification': idNotification,
      'texte': texte,
      'date': date,
      'utilisateur': utilisateur.toMap(),
      'budget': budget.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      idNotification: map['idNotification'] as int,
      texte: map['texte'] as String,
      date: map['date'] as String,
      utilisateur: Utilisateur.fromJson(map['utilisateur'] as Map<String,dynamic>),
      budget: Budget.fromJson(map['budget'] as Map<String,dynamic>),
    );
  }

factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        idNotification: json["idNotification"],
        texte: json["texte"],
        date: json["date"],
        utilisateur: Utilisateur.fromJson(json["utilisateur"]),
        budget: Budget.fromJson(json["budget"]),
    );
}
