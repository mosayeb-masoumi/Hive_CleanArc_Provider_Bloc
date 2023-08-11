import '../entity/contact.dart';

abstract class ContactRepository {
  Future<dynamic> getContacts(String? searchQuery);
  void addContact(Contact contact);
  void deleteContact(Contact contact);
  void clearDB();
}