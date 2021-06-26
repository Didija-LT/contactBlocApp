import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/ui/pages/contacts/widgets/contacts.button.item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactsBarButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContactButtonItem(buttonLabel: 'All Contact', contactsEvent: new LoadAllContactsEvent(),),
          ContactButtonItem(buttonLabel: 'Student', contactsEvent: new LoadStudentsEvent(),),
          ContactButtonItem(buttonLabel: 'Developers', contactsEvent: new LoadDevelopersEvent(),),
        ],
      ),
    );
  }
}
