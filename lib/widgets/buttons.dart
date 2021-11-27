import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  final String title;
  final void Function() action;

  @override
  Widget build(BuildContext context) => Button(
        key: key,
        title: title,
        action: action,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        bgColor: HexColor("#529cda"),
      );
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  final String title;
  final void Function() action;

  @override
  Widget build(BuildContext context) => Button(
        key: key,
        title: title,
        action: action,
        textStyle: TextStyle(
          color: Colors.black87,
        ),
        bgColor: HexColor("#f6f6f9"),
      );
}

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  final String title;
  final void Function() action;

  @override
  Widget build(BuildContext context) => Button(
        key: key,
        title: title,
        action: action,
        // textStyle: Theme.of(context).textTheme.bodyText1,
        bgColor: Colors.transparent,
      );
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.title,
    required this.action,
    this.disabled = false,
    this.textStyle,
    this.bgColor,
    this.decoration,
  }) : super(key: key);

  final String title;
  final void Function() action;
  final bool disabled;
  final TextStyle? textStyle;
  final Color? bgColor;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: (screenWidth >= 385 ? 55 : 49),
      width: double.infinity,
      decoration: decoration ?? BoxDecoration(color: Colors.transparent),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(8),
            elevation: 0,
            primary: bgColor,
            shadowColor: Colors.transparent),
        child: Text(
          title,
          style: textStyle,
          maxLines: (screenWidth >= 385 ? 2 : 1),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: disabled == false ? action : null,
      ),
    );
  }
}
