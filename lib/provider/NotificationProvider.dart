import 'package:flutter/material.dart';
import 'package:ika_musaka/model/NotificationModel.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifList = [];

  List<NotificationModel> get notifList => _notifList;

  void setNotifList(List<NotificationModel> newList) {
    _notifList = newList;
    notifyListeners();
  }
}
