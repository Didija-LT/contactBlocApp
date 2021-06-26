import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorRetryMessage extends StatelessWidget {
  String errorMessage;
  Function onAction;
   ErrorRetryMessage({required this.errorMessage,required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${errorMessage}"),
        // ignore: deprecated_member_use
        RaisedButton(
          child: Text('Retry', style: TextStyle(color: Colors.white),),
          onPressed: () => onAction,
          color: Colors.deepOrange,
        )
      ],
    );
  }
}
