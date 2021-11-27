import 'package:flutter_sample/models/error.dart';
import 'package:hive/hive.dart';

class ErrorRepository {
  static register() async {
    Hive.registerAdapter(ErrorAdapter());
  }

  static getErrors() async {
    var box = await Hive.openBox<Error>('errors');
    return box.values.toList();
  }

  static addError(Error error) async {
    var box = await Hive.openBox<Error>('errors');

    await box.add(error);
  }

  static updateError(Error error) async {
    await error.save();
  }

  static deleteError(Error error) async {
    await error.delete();
  }

  static clear() async {
    var box = await Hive.openBox<Error>('errors');
    await box.clear();
  }
}
