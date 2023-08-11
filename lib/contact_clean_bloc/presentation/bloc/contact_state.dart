part of 'contact_cubit.dart';

@immutable
abstract class ContactState {
  const ContactState() ;
}

class ContactInitial extends ContactState {
  const ContactInitial();
}


class ContactLoading extends ContactState {
  const ContactLoading();
}

class ContactLoaded extends ContactState {
  final List<Contact> list;
  const ContactLoaded(this.list);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactLoaded &&
          runtimeType == other.runtimeType &&
          list == other.list;

  @override
  int get hashCode => list.hashCode;
}

class ContactError extends ContactState {
  final String error;
  const ContactError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
