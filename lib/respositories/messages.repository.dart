import 'dart:math';

import 'package:contacts_bloc_app/model/message.model.dart';

class MessageRepository {
  int messageCounter = 0;


  Map<int,Message> messages = {
    1:Message(id: 1, contactId: 1, dateTime: DateTime.now(), content: 'Hello world', type: 'sent',selected: false),
    2:Message(id: 2, contactId: 2, dateTime: DateTime.now(), content: 'long messsage long messsage long messsage  ', type: 'sent',selected: false),
    2:Message(id: 2, contactId: 2, dateTime: DateTime.now(), content: 'long messsage 2 long messsage 2 long messsage 2 long messsage 2 long messsage 2 ', type: 'received',selected: false),
    3:Message(id: 3, contactId: 3, dateTime: DateTime.now(), content: 'Please', type: 'sent',selected: false),
    4:Message(id: 4, contactId: 4, dateTime: DateTime.now(), content: 'Chokran', type: 'received',selected: false),
    5:Message(id: 5, contactId: 5, dateTime: DateTime.now(), content: 'Merci', type: 'sent',selected: false),
  };

  MessageRepository() {
    this.messageCounter = messages.length;
  }

  Future<List<Message>> allMessages() async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 1){
      return messages.values.toList();
    }else{
      throw new Exception("Network connexion");
    }
  }

  Future<List<Message>> messagesByContact(int contactId) async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 3){
      return messages.values.toList().where((element) => element.contactId == contactId).toList();
    }else{
      throw new Exception("Network connexion");
    }
  }

  Future<Message> addNewMessage(Message message) async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 3){
      message.id = ++messageCounter;
      messages[message.id] = message;
      return message;
    }else{
      throw new Exception("Network connexion");
    }
  }

  Future<void> deleteMessage(Message message) async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 1){
      messages.remove(message.id);

    }else{
      throw new Exception("internet error");
    }
  }

}