import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/ui/pages/message/wigets/messages.list.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesWidget extends StatelessWidget {
 // const MessagesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
    return Container();
  }
}
