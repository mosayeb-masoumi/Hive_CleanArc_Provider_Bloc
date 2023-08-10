import 'package:hive/hive.dart';

import '../../note_clean_provider/domain/entity/note/note.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AppDatabase {
  late Box<Note> _notesBox;

  Future<void> init() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // register table note
    Hive.registerAdapter(NoteAdapter());

    // _notesBox = await Hive.openBox<Note>('notes');
    // register table contact
  }

  //************************  Note Db Methods  **************************//
  Future<List<Note>> getNotes() async {
    _notesBox = await Hive.openBox<Note>("notes");
    return _notesBox.values.toList();
  }

  Future<void> addOrUpdateNote(Note note) async {

    _notesBox = await Hive.openBox<Note>("notes");

    if (note.key == null) {
      await _notesBox.add(note); // add
    } else {
      await note.save();  // update
    }
  }

  Future<void> deleteNote(Note note) async {
    _notesBox = await Hive.openBox<Note>("notes");
    if (note.key != null) {
      await _notesBox.delete(note.key);
    }
  }

  Future<void> clearNoteDb() async {
    await _notesBox.clear();
  }


//************************  Contact Db Methods  **************************//

}
