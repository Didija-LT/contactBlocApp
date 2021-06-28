import 'dart:ffi';
import 'dart:html';

import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/model/message.model.dart';

class MessageState{

  List<Message> messages;
  RequestState requestState;
  String errorMessage;
  MessageEvent currentMsgEvent;
  List<MessageState> selectedMessages=[];
  Contact currentContact;

  MessageState({ required this.messages,
    required this.requestState, required this.errorMessage,
    required this.currentMsgEvent, required this.selectedMessages,
      required this.currentContact});

  MessageState.initialeState() : requestState = RequestState.NONE,
        messages = [], errorMessage = '', selectedMessages=[]  ,
       currentMsgEvent = null , currentContact= new Contact() ;
}