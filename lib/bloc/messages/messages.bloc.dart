import 'package:bloc/bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/model/message.model.dart';
import 'package:contacts_bloc_app/respositories/messages.repository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState>{

  MessageRepository messageRepository;
  MessageBloc messageBloc;

  MessageBloc({ required MessageState initialeState, required this.messageRepository, required this.messageBloc}) : super(initialeState);

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if(event is MessagesByContacEvent){
      yield MessageState(messages: state.messages, requestState: RequestState.LOADING, errorMessage: '', currentMsgEvent: event,selectedMessages: state.selectedMessages, currentContact: event.payload);
      try{
        List<Message> data = await messageRepository.allMessages(); //.messagesByContact(event.payload.id); // Id of contact
        yield MessageState(messages: data, requestState: RequestState.LOADED, errorMessage: '', currentMsgEvent: event,selectedMessages: state.selectedMessages, currentContact: event.payload);
      }catch(e){
        yield MessageState(messages: state.messages, requestState: RequestState.ERROR, errorMessage: e.toString(), currentMsgEvent: event,selectedMessages: state.selectedMessages, currentContact: event.payload);
      }
    } else if(event is AddNewMessageEvent){
      // yield MessageState(messages: state.messages, requestState: RequestState.LOADING, errorMessage: '', currentEvent: event);
      try{
        event.payload.dateTime = DateTime.now();
        Message message = await messageRepository.addNewMessage(event.payload);
        List<Message> data = [...state.messages];
        data.add(message);
        yield MessageState(messages: data, requestState: RequestState.LOADED, errorMessage: '', currentMsgEvent: event,selectedMessages: state.selectedMessages , currentContact: state.currentContact);
      }catch(e){
        yield MessageState(messages: state.messages, requestState: RequestState.ERROR, errorMessage: e.toString(), currentMsgEvent: event,selectedMessages: state.selectedMessages, currentContact: state.currentContact );
      }
    }
    else if(event is SelectMessageEvent){
      List<Message> message=state.messages;
      List<Message> selected=state.selectedMessages.cast<Message>();
       for(Message m in message){
         if(m.id==event.payload.id){
           m.selected=!m.selected;
         }
         if(m.selected==true){
           selected.add(m);
         }
         else{
           selected.removeWhere((element) => element.id==m.id);
         }
      }
    }
    else if(event is DeleteMessageEvent){
      List<Message> message=state.messages;
      List<Message> selected=state.selectedMessages.cast<Message>();
      for(Message m in selected){
        try {
          await messageRepository.deleteMessage(m);
          message.removeWhere((element) => element.id==m.id);
          MessageState messageState= MessageState(messages: message, requestState: RequestState.LOADED, errorMessage: '', currentMsgEvent: event , selectedMessages: state.selectedMessages);
          yield messageState;
        } catch (e) {
         // print(e);
          MessageState messageState= MessageState(messages: message, requestState: RequestState.ERROR , errorMessage: '', currentMsgEvent: event , selectedMessages: state.selectedMessages);
          yield messageState;
        }
        }

      }
    }
  }

