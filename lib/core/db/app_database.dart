import 'package:hive/hive.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/entity/contact.dart';

import '../../note_clean_provider/domain/entity/note/note.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class AppDatabase {
  late Box<Note> _notesBox;
  late Box<Contact> _contactsBox;

  Future<void> init() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // register table note
    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(ContactAdapter());

    // _notesBox = await Hive.openBox<Note>('notes');
    // register table contact
  }

  //************************  Note Db Methods  **************************//


     /************* get list **************/
  // Future<List<Note>> getNotes() async {
  //   _notesBox = await Hive.openBox<Note>('notes');
  //   return _notesBox.values.toList();
  // }


  /************* get list and search **************/
  Future<List<Note>> getNotes({String? searchQuery}) async {

    if(!Hive.isBoxOpen('notes')){
      _notesBox = await Hive.openBox<Note>('notes');
    }
    // _notesBox = await Hive.openBox<Note>('notes');

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      // Perform a query search if searchQuery is provided
      return _notesBox.values.where((note) {
        return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    } else {
      return _notesBox.values.toList();
    }
  }



  Future<void> addOrUpdateNote(Note note) async {
    if(!Hive.isBoxOpen('notes')){
      _notesBox = await Hive.openBox<Note>('notes');
    }
    // _notesBox = await Hive.openBox<Note>('notes');
    if (note.key == null) {
      await _notesBox.add(note); // add
    } else {
      await note.save();  // update
    }
  }

  Future<void> deleteNote(Note note) async {
    if(!Hive.isBoxOpen('notes')){
      _notesBox = await Hive.openBox<Note>('notes');
    }
    // _notesBox = await Hive.openBox<Note>('notes');
    if (note.key != null) {
      await _notesBox.delete(note.key);
    }
  }

  Future<void> clearNoteDb() async {
    if(!Hive.isBoxOpen('notes')){
      _notesBox = await Hive.openBox<Note>('notes');
    }
    // _notesBox = await Hive.openBox<Note>('notes');
    await _notesBox.clear();
    await _notesBox.compact();
  }








//************************  Contact Db Methods  **************************//

  /************* get list **************/
  // Future<List<Contact>> getContacts() async {
  //   _contactsBox = await Hive.openBox<Contact>('contacts');
  //   return _contactsBox.values.toList();
  // }


  /************* get list and search **************/
  Future<List<Contact>> getContacts({String? searchQuery}) async {
    if(!Hive.isBoxOpen('contacts')){
      _contactsBox = await Hive.openBox<Contact>('contacts');
    }
    // _contactsBox = await Hive.openBox<Contact>('contacts');

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      // Perform a query search if searchQuery is provided
      return _contactsBox.values.where((contact) {
        return contact.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            contact.phone.toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    } else {
      return _contactsBox.values.toList();
    }
  }



  Future<void> addOrUpdateContact(Contact contact) async {
    if(!Hive.isBoxOpen('contacts')){
      _contactsBox = await Hive.openBox<Contact>('contacts');
    }
    // _contactsBox = await Hive.openBox<Contact>('contacts');
    if (contact.key == null) {
      await _contactsBox.add(contact); // add
    } else {
      await contact.save();  // update
    }
  }

  Future<void> deleteContact(Contact contact) async {
    if(!Hive.isBoxOpen('contacts')){
      _contactsBox = await Hive.openBox<Contact>('contacts');
    }
    // _contactsBox = await Hive.openBox<Contact>('contacts');
    if (contact.key != null) {
      await _contactsBox.delete(contact.key);
    }
  }

  Future<void> clearContactDb() async {
    if(!Hive.isBoxOpen('contacts')){
      _contactsBox = await Hive.openBox<Contact>('contacts');
    }
    // _contactsBox = await Hive.openBox<Contact>('contacts');
    await _contactsBox.clear();
    await _contactsBox.compact();
  }

}
