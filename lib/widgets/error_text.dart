import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text(
              text!,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          )
        : Container();
  }
}
