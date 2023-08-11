import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/entity/contact.dart';
import 'package:hive_clean_provider_bloc/contact_clean_bloc/domain/repository/contact_repository.dart';

class ContactUseCase extends ContactRepository{
  ContactRepository _repository;
  ContactUseCase(this._repository);

  @override
  void addContact(Contact contact) {
    return _repository.addContact(contact);
  }

  @override
  void clearDB() {
    return _repository.clearDB();
  }

  @override
  void deleteContact(Contact contact) {
    return _repository.deleteContact(contact);
  }

  @override
  Future getContacts(String? searchQuery) {
    return _repository.getContacts(searchQuery);
  }

}