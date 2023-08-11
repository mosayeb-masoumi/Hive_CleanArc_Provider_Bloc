

import '../entity/note/note.dart';

abstract class NoteRepository {
  Future<dynamic> getNotes(String? searchQuery);
  void addNote(Note note);
  void deleteNote(Note note);
  void clearDB();
}