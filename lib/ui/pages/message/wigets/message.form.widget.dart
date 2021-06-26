import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/model/message.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesForm extends StatelessWidget {
  TextEditingController textEditingController = new TextEditingController();
  Contact contact;

  MessagesForm(this.contact);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                   hintText: "your message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    )),
              )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              Message message = Message(id: 0 , contactId: contact.id, dateTime: DateTime.now() , content: textEditingController.text, type: 'sent', selected: false);
              context.read<MessageBloc>().add(new AddNewMessageEvent(message));

              Message reply = Message(id: 0 , contactId: contact.id, dateTime: DateTime.now()  , content: 'Answer to ${textEditingController.text}', type: 'received', selected: false );
              context.read<MessageBloc>().add(new AddNewMessageEvent(reply));

              textEditingController.text = '';
            },
          )
        ],
      ),
    );
  }
}