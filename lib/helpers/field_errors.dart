import 'package:collection/collection.dart';

FieldError? getFirstError(List<FieldError> errors, String field) {
  return errors.firstWhereOrNull((error) => error.field == field);
}

class FieldError {
  String field;
  String message;

  FieldError({required this.field, required this.message});
}
