class Depense {
  String description;
  double montant;
  String type;
  DateTime date;
  String idDepenses;

  // Constructeur
  Depense({
    required this.description,
    required this.montant,
    required this.type,
    required this.date,
    required this.idDepenses

  });

  factory Depense.fromJson(Map<String, dynamic> json) {
    return Depense(
      description: json['description'],
      montant: json['montant'],
      type: json['type'],
      date: json['date'],
      idDepenses: json['idDepenses'],
     
    );
  }
}