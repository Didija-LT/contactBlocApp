import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.widget.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/ui/pages/contacts/widgets/contact.info.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/message.form.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.appbar.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.list.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagePage extends StatelessWidget {
   late Contact contact;
  @override
   Widget build(BuildContext context) {
     context.read<MessageBloc>().add(MessagesByContacEvent(this.contact));

     // if(ModalRoute.of(context) != null){
     this.contact = ModalRoute.of(context)!.settings.arguments as Contact;
     // }

     return Scaffold(
       appBar: MyAppBarWidget(this.contact),
       body: Column(
         children: [
           ContactInfoWidget(contact),
           MessagesWidget(),
           MessagesForm(contact),
         ],
       ),
     );
   }
}
