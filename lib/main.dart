
import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/respositories/contacts.repo.dart';
import 'package:contacts_bloc_app/respositories/messages.repository.dart';
import 'package:contacts_bloc_app/ui/pages/contacts/contacts.page.dart';
import 'package:contacts_bloc_app/ui/pages/contactsWithMessages/contacts.messages.page.dart';
import 'package:contacts_bloc_app/ui/pages/message/messages.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => new ContactsRepository() );
  GetIt.instance.registerLazySingleton(() => new MessageRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MessageBloc(
                initialeState: MessageState.initialeState(),
                messageRepository: GetIt.instance<MessageRepository>(),
                messageBloc: context.read<MessageBloc>()
            ),),
        BlocProvider(create: (context) => ContactBloc(
            initialState:  ContactsState(
                  contacts: [],
                  requestState: RequestState.NONE,
                  errorMessage: '',
                  currentEvent: new LoadStudentsEvent(),
                  currentContact: new Contact()),
                  contactsRepository: GetIt.instance<ContactsRepository>(),
                  messageBloc: context.read<MessageBloc>()
          ),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        routes: {
          '/contacts':(context)=>ContactPage(),
          '/message':(context)=>MessagePage(),
          '/contactsWithMessage':(context)=>ContactWithMessages(),
        },
        initialRoute: '/contacts',
      ),
    );
  }
}
