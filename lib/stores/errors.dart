import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sample/models/error.dart';
import 'package:flutter_sample/repositories/error_repository.dart';

class Errors with ChangeNotifier {
  List<Error> errors = [];

  loadErrors({reload = false}) async {
    if (errors.isEmpty || reload) {
      errors = await ErrorRepository.getErrors();
      notifyListeners();
    }

    return errors;
  }

  addError(String type, String text) async {
    var error = new Error(id: DateTime.now().millisecondsSinceEpoch, type: type, text: text);

    errors.add(error);
    await ErrorRepository.addError(error);

    notifyListeners();
  }

  updateError(Error error) async {
    await ErrorRepository.updateError(error);
    notifyListeners();
  }

  deleteError(Error error) async {
    await ErrorRepository.deleteError(error);

    notifyListeners();
  }

  clearAllErrors() async {
    await ErrorRepository.clear();
    errors.clear();

    notifyListeners();
  }

  Future<String> exportToJsonData() async {
    await loadErrors();
    return jsonEncode(errors);
  }

  importFromJsonData(jsonArray) async {
    await ErrorRepository.clear();
    errors.clear();

    for (var element in jsonArray) {
      var error = Error.fromJson(element);
      await ErrorRepository.addError(error);

      errors.add(error);
    }

    notifyListeners();
  }
}
