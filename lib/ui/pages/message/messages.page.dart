import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/ui/pages/contacts/widgets/contact.info.widget.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/message.form.widget.dart';
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
       appBar: AppBar(
         title: Text('Messages de ${contact.name}'),
         actions: [
           BlocBuilder <MessageBloc,MessageState>(
             builder: (context , state){
               if(state.selectedMessages.length>0){
               return IconButton( icon: Icon(Icons.restore_from_trash) ,
               onPressed: (){
              context.read<MessageBloc>().add(new DeleteMessageEvent());
              }, );
             }
              else{
               return Container();
           }
           },
           ),
           BlocBuilder <MessageBloc,MessageState>(
             builder: (context , state){
              return CircleAvatar( child: Text('${state.messages.length}'),);
             },
           )
         ],
        ),
       body: Column(
         children: [
           ContactInfoWidget(contact),
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
           MessagesForm(contact),
         ],
       ),
     );
   }
}
