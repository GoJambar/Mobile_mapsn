import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    // required Key key,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onClicked,
        //color: Theme.of(context).primaryColor,
        color: Colors.green,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
}
