import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/message.form.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.list.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactWithMessages extends StatelessWidget {


  //const ContactWithMessages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ContactBloc>().add(new LoadAllContactsEvent());
    return Scaffold(
      appBar: AppBar(title: Text('Contacts With Messages'),),
      body: Column(
        children:[ BlocBuilder<ContactBloc,ContactsState>(
          builder: (context , state) {
            if(state.requestState==RequestState.LOADING){
              return Center(child: CircularProgressIndicator(),);
            }else if(state.requestState==RequestState.ERROR){
              return ErrorRetryMessage(errorMessage: state.errorMessage, onAction: (){
                context.read<ContactBloc>().add(state.currentEvent);
              });
            }
             else if(state.requestState==RequestState.LOADED){
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  itemBuilder: (context , state) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            context.read<MessageBloc>().add(new MessagesByContacEvent(state.contacts[index]));
                          },
                          child: BlocBuilder<MessageBloc,MessageState>(
                            builder: (context, messageState) => Container(
                              width: 100,
                              padding: EdgeInsets.all(16),
                              child: Column(children: [
                                CircleAvatar(child: Text('${state.contacts[index].profile}') ,),
                                Text('${state.contacts[index].name}'),
                                Text('${state.contacts[index].score}'),
                              ]),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: (messageState.currentContact==state.contacts[index]) ?3:1)
                              ),
                            ),
                          ),
                        ),
                      ),
                  itemCount: state.contacts.length,
                  scrollDirection: Axis.horizontal,
                ),
              );
            }
             else {
               return Container();
            }
          }

        ),
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state){
                if(state.requestState == RequestState.LOADING){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if(state.requestState == RequestState.ERROR){
                  return ErrorRetryMessage(errorMessage: state.errorMessage, onAction: (){
                    context.read<MessageBloc>().add(state.currentMsgEvent);
                  });
                } else if(state.requestState == RequestState.LOADED){
                  return MessagesList(state.messages);
                } else{
                  return Container();
                }
              },
            ),
          ),
          BlocBuilder<ContactBloc,ContactsState>(
              builder: (context,state)=>MessagesForm(state.currentContact))
        ],
      )
    );
  }
}
