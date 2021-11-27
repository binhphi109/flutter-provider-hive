import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'flutter_sample',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
