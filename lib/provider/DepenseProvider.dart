import 'package:flutter/foundation.dart';

import '../model/Depense.dart';


class DepensesProvider extends ChangeNotifier {
  List<Depense> _depenses = [];

  List<Depense> get depenses => _depenses;

  void ajouterDepense(Depense nouvelleDepense) {
    _depenses.add(nouvelleDepense);
    notifyListeners();
  }
}