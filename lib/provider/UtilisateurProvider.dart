import 'package:flutter/foundation.dart';

import '../model/utilisateur.dart';

class UtilisateurProvider with ChangeNotifier {
  Utilisateur? _utilisateur;

  Utilisateur? get utilisateur => _utilisateur;

  void setUtilisateur(Utilisateur utilisateur) {
    _utilisateur = utilisateur;
    notifyListeners();
  }
}
