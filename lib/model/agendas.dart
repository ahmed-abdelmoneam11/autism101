import 'package:flutter/material.dart';

///the module where the data of agenda saved in list

class Agenda {
  final int id;
  String title;

  Agenda({
    required this.id,
     required this.title,
  });
}

class Agendas with ChangeNotifier {
  List<Agenda> AgendasList = [];

  void add({required String title}) {
    AgendasList.add(Agenda(
      id: 1,
      title: title,
    ));
    notifyListeners();
  }
}
