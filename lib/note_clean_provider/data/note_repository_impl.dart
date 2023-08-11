import 'package:hive_clean_provider_bloc/note_clean_provider/domain/entity/note/note.dart';
import 'package:hive_clean_provider_bloc/note_clean_provider/domain/repository/note_repository.dart';

import '../../core/db/app_database.dart';

class NoteRepositoryImpl extends NoteRepository {
  final AppDatabase _db;

  NoteRepositoryImpl(this._db);

  @override
  void addNote(Note note) async {
    _db.addOrUpdateNote(note);
  }

  @override
  void deleteNote(Note note) async {
    _db.deleteNote(note);
  }

  @override
  Future getNotes(String? searchQuery) async {
    return _db.getNotes(searchQuery: searchQuery);
  }


  @override
  void clearDB() async {
    _db.clearNoteDb();
  }
}
