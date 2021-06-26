import 'dart:math';

import 'package:contacts_bloc_app/model/contact.model.dart';

class ContactsRepository{
  Map<int,Contact> contacts={
    1:Contact(1 , 'Mohamed', 'MO', 1234 , 'Student'),
    2:Contact(2 , 'Yassine', 'YA', 432 , 'Student'),
    3:Contact(3 , 'Imane', 'IM', 654 , 'Developer'),
    4:Contact(4 , 'Hanan', 'HA', 875 , 'Student'),
  };

  Future<List<Contact>> allContacts() async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 1){
      return contacts.values.toList();
    }else{
      throw new Exception("Network connexion");
    }
  }

  Future<List<Contact>> contactsByType(String type) async{
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if(rnd > 3){
      return contacts.values.toList().where((element) => element.type == type).toList();
    }else{
      throw new Exception("Network connexion");
    }
  }
}