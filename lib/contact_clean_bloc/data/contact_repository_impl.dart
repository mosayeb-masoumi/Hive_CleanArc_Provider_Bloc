
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/entity/contact.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/repository/contact_repository.dart';
import 'package:hive_clean_provider_bloc/core/db/app_database.dart';

class ContactRepositoryImpl extends ContactRepository{

  final AppDatabase _db;
  ContactRepositoryImpl(this._db);

  @override
  void addContact(Contact contact) async {
     _db.addOrUpdateContact(contact);
  }

  @override
  void clearDB() {
    _db.clearContactDb();
  }

  @override
  void deleteContact(Contact contact) async {
    _db.deleteContact(contact);
  }

  @override
  Future getContacts(String? searchQuery) async{
    return _db.getContacts(searchQuery: searchQuery);
  }

}