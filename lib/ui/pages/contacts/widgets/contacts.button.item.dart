import 'package:contacts_bloc_app/bloc/contacts.actions.dart';
import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactButtonItem extends StatelessWidget {
  String buttonLabel;
  ContactsEvent contactsEvent;

  ContactButtonItem({required this.buttonLabel, required this.contactsEvent});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return BlocBuilder<ContactBloc,ContactsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: (state.currentEvent.runtimeType==contactsEvent.runtimeType)?2:0,
                  color: Colors.deepOrange
              )
          ),

          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: ()=> {
              context.read<ContactBloc>().add(contactsEvent)
            },
            child: Text( buttonLabel , style: TextStyle( color:  Colors.white),)
            , color: Colors.deepOrange,
          ),
        );
      },
    );
  }
}
