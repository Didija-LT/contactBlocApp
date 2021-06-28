import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/model/contact.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ContactHorizontalItemWidget extends StatelessWidget {
 // const ContactHorizontalItemWidget({Key key}) : super(key: key);
 Contact  contact;
 int index;
 ScrollController  scrollController;
 ContactHorizontalItemWidget(this.contact , this.index, this.scrollController);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          context.read<MessageBloc>().add(new MessagesByContacEvent(contact));
          scrollController.animateTo((index*200-150).toDouble(), duration: Duration(microseconds: 2000), curve:Curves.ease);
        },
        child: BlocBuilder<MessageBloc,MessageState>(
          builder: (context, messageState) => Card(
            elevation: 1,
            child: Container(
              width: 150,
              padding: EdgeInsets.all(16),
              child: Column(children: [
                CircleAvatar(child: Text('${state.contacts[index].profile}') ,),
                Text('${state.contacts[index].name}'),
                Text('${state.contacts[index].score}'),
              ]),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: (messageState.currentContact==contact) ?3:1)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
