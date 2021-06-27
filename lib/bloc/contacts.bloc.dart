import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/respositories/contacts.repo.dart';






class ContactBloc extends Bloc<ContactsEvent, ContactsState>{
  ContactsRepository contactsRepository;
  MessageBloc messageBloc;
  ContactBloc({required ContactsState initialState, required this.contactsRepository , required this.messageBloc}) : super(initialState);

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async*{
    if(event is LoadAllContactsEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, errorMessage: '',currentEvent:event,currentContact:);
      try{
        List<Contact> data= await contactsRepository.allContacts();
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, errorMessage: '',currentEvent:event,currentContact: data[0]);
        messageBloc.add(new MessagesByContacEvent(data[0]));
      }catch (e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString() ,currentEvent:event, currentContact: );
      }

    }else if(event is LoadStudentsEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event, errorMessage: '', currentContact: );
      try{
        List<Contact> data = await contactsRepository.contactsByType('STUDENT');
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event, errorMessage: '',currentContact: );
      }catch(e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString(), currentEvent: event,currentContact: );
      }

    }else if(event is LoadDevelopersEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event, errorMessage: '',currentContact: );
      try{
        List<Contact> data = await contactsRepository.contactsByType('DEVELOPER');
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event, errorMessage: '',currentContact: );
      }catch(e){
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.toString(), currentEvent: event,currentContact: );
      }

    }
  }
  }

