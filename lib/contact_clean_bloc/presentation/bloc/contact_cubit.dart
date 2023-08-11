import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/contact.dart';
import '../../domain/usecase/contact_usecase.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {

  final ContactUseCase _usecase;
  ContactCubit(this._usecase) : super(const ContactInitial());

   Future<dynamic> getContacts(String? searchQuery) async {
     try{
       emit(const ContactLoading());
       var result = await _usecase.getContacts(searchQuery);
       emit(ContactLoaded(result));
     }catch(error){
       emit(ContactError(error.toString()));
     }
   }



  void addContact(Contact contact) {
    _usecase.addContact(contact);
    getContacts(null);
  }

  void deleteContact(Contact contact) {
    _usecase.deleteContact(contact);
    getContacts(null);
  }

  void clearDB() {
    _usecase.clearDB();

    List<Contact> list =[];
    emit(ContactLoaded(list));
    // getContacts(null);
  }



  // Future<dynamic> searchInDb(searchQuery) async {
  //   _list = await _useCase.getNotes(searchQuery);
  //
  // }
}
