import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastSuccess(message) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.teal);
}

showToastWarning(message) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.amber);
}

showToastError(message) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
}
