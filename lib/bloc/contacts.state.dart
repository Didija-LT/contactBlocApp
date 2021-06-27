import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';

class ContactsState{
  List<Contact> contacts;
  RequestState requestState;
  String errorMessage;
  ContactsEvent currentEvent;
  Contact currentContact;

  ContactsState({required this.contacts,required this.requestState, required this.errorMessage , required this.currentEvent, required this.currentContact});
}
