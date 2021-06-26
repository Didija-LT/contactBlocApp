
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:contacts_bloc_app/model/message.model.dart';

abstract class MessageEvent<T>{
  T payload;
  MessageEvent(this.payload);
}

class MessagesByContacEvent extends MessageEvent<Contact>{
  MessagesByContacEvent(Contact payload) : super(payload);
}

class AddNewMessageEvent extends MessageEvent<Message>{
  AddNewMessageEvent(Message payload) : super(payload);
}
class SelectMessageEvent extends MessageEvent<Message>{
  SelectMessageEvent(Message payload) : super(payload);
}
class DeleteMessageEvent extends MessageEvent{
  DeleteMessageEvent() : super(null);
}