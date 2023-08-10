

import '../entity/note/note.dart';

abstract class NoteRepository {
  Future<dynamic> getNotes();
  void addNote(Note note);
  void deleteNote(Note note);
  void clearDB();
}