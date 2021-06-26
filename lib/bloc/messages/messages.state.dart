import 'dart:ffi';

import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/message.model.dart';

class MessageState{

  List<Message> messages;
  RequestState requestState;
  String errorMessage;
  MessageEvent currentMsgEvent;
  List<MessageState> selectedMessages=[];

  MessageState({ required this.messages,
    required this.requestState, required this.errorMessage,
    required this.currentMsgEvent, required this.selectedMessages});

  MessageState.initialeState() : requestState = RequestState.NONE,
        messages = [], errorMessage = '', selectedMessages=[]  ,
       currentMsgEvent = null ;
}