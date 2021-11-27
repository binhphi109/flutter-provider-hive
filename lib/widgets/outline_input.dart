import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlineInput extends StatelessWidget {
  final String? heading;
  final TextEditingController controller;
  final bool? autoFocus;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? readOnly;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final Function()? onTap;
  final ValueChanged<String>? onSubmitted;

  OutlineInput({
    Key? key,
    this.heading,
    required this.controller,
    this.autoFocus,
    this.keyboardType,
    this.obscureText,
    this.maxLength,
    this.readOnly,
    this.hintText,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            heading != null
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      heading!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))
                : Container(),
            heading != null ? SizedBox(height: 8) : Container(),
            InkWell(
              onTap: onTap ?? () {},
              child: IgnorePointer(
                ignoring: onTap != null,
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType ?? TextInputType.text,
                  autocorrect: false,
                  autofocus: autoFocus ?? false,
                  obscureText: obscureText ?? false,
                  readOnly: readOnly ?? false,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                    hintText: hintText,
                    labelText: labelText,
                    errorText: errorText,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  ),
                  onSubmitted: onSubmitted,
                ),
              ),
            ),
          ],
        ),
      );
}
