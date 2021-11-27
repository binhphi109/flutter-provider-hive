import 'package:flutter/material.dart';
import 'package:flutter_sample/helpers/dialogs.dart';
import 'package:flutter_sample/stores/settings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmptyWrapper extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String content;
  final List<dynamic> data;
  final Widget child;

  EmptyWrapper({
    Key? key,
    this.icon,
    required this.title,
    required this.content,
    required this.data,
    required this.child,
  }) : super(key: key);

  DateTime? dateFormated(String stringDate) {
    try {
      var date = DateFormat('dd/MM/yyyy').parse(stringDate);
      print('dateFormated: $date');
      return date;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => data.length == 0
      ? Container(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon != null
                  ? ClipOval(
                      child: Material(
                        color: Colors.blueGrey.shade200, // Button color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(icon, color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 8),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(content, textAlign: TextAlign.center, style: TextStyle()),
              ),
            ],
          ),
        )
      : child;
}
