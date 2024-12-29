import 'package:flutter/material.dart';


class notesProvider extends ChangeNotifier{
  List<String> notes = [];

  void addNotes (String note){
    notes.add(note);
    notifyListeners();
  }

  void deleteNotes (String note){
    notes.remove(note);
    notifyListeners();
  }
}