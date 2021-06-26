import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/respositories/contacts.repo.dart';






class ContactBloc extends Bloc<ContactsEvent, ContactsState>{
  ContactsRepository contactsRepository;
  ContactBloc({required ContactsState initialState, required this.contactsRepository}) : super(initialState);

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async*{
    if(event is LoadAllContactsEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, errorMessage: '',currentEvent:event);
      try{
        List<Contact> data= await contactsRepository.allContacts();
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, errorMessage: '',currentEvent:event);
      }catch (e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString() ,currentEvent:event);
      }

    }else if(event is LoadStudentsEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event, errorMessage: '');
      try{
        List<Contact> data = await contactsRepository.contactsByType('STUDENT');
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event, errorMessage: '');
      }catch(e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString(), currentEvent: event);
      }

    }else if(event is LoadDevelopersEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event, errorMessage: '');
      try{
        List<Contact> data = await contactsRepository.contactsByType('DEVELOPER');
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event, errorMessage: '');
      }catch(e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString(), currentEvent: event);
      }

    }
  }
  }

