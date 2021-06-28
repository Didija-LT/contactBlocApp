import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.widget.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/ui/pages/contactsWithMessages/widgets/contacts.list.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/message.form.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.appbar.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.list.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactWithMessages extends StatelessWidget {


  //const ContactWithMessages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ContactBloc>().add(new LoadAllContactsEvent());
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context,state) => Scaffold(
        appBar: MyAppBarWidget(state.currentContact),
        body: Column(
          children:[ ContactsListHorizontalWidget() ,
            MessagesWidget(),
            MessagesForm(state.currentContact),
          ],
        )
      ),
    );
  }
}
