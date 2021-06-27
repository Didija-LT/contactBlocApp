import 'package:contacts_bloc_app/bloc/contacts.bloc.dart';
import 'package:contacts_bloc_app/bloc/contacts.state.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contacts_bloc_app/bloc/messages/messages.state.dart';
import 'package:contacts_bloc_app/enums/enums.dart';
import 'package:contacts_bloc_app/ui/pages/contactsWithMessages/widgets/contact.horizontal.item.widget.dart';
import 'package:contacts_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListHorizontalWidget extends StatelessWidget {
  ScrollController  scrollController= new ScrollController();
 // const ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc,ContactsState>(
        builder: (context , state) {
          if(state.requestState==RequestState.LOADING){
            return Center(child: CircularProgressIndicator(),);
          }else if(state.requestState==RequestState.ERROR){
            return ErrorRetryMessage(errorMessage: state.errorMessage, onAction: (){
              context.read<ContactBloc>().add(state.currentEvent);
            });
          }
          else if(state.requestState==RequestState.LOADED){
            return SizedBox(
              height: 150,
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context , state) =>
                    ContactHorizontalItemWidget(),
                itemCount: state.contacts.length,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          else {
            return Container();
          }
        }

    );
  }
}
