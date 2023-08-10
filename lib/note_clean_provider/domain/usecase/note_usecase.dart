

import '../entity/note/note.dart';
import '../repository/note_repository.dart';

class NoteUseCase extends NoteRepository{

  NoteRepository _repository;
  NoteUseCase(this._repository);

  @override
  Future getNotes() {
    return _repository.getNotes();
  }

  @override
  void addNote(Note note) {
    _repository.addNote(note);
  }

  @override
  void deleteNote(Note note) {
    _repository.deleteNote(note);
  }

  @override
  void clearDB() {
    _repository.clearDB();
  }

}