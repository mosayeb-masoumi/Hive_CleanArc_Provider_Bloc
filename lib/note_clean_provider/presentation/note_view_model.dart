import 'package:flutter/cupertino.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/domain/usecase/note_usecase.dart';

import '../domain/entity/note/note.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteUseCase _useCase;

  NoteViewModel(this._useCase);

  List<Note> _list = [];

  List<Note> get list => _list;


  void initDB() {
    _useCase.clearDB();
  }

  Future<dynamic> getNotes() async {
    _list = await _useCase.getNotes();
    notifyListeners();
  }

  void addNote(Note note) {
    _useCase.addNote(note);
    getNotes();
  }

  void deleteNote(Note note) {
    _useCase.deleteNote(note);
    getNotes();
  }

  void clearDB() {
    _useCase.clearDB();
  }
}
