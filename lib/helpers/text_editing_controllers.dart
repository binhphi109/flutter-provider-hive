import 'package:flutter/material.dart';

class CurrencyTextEditingController extends TextEditingController {
  CurrencyTextEditingController({
    double initialValue = 0.0,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
    this.precision = 2,
  }) {
    validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String? decimalSeparator;
  final String? thousandSeparator;
  final String? rightSymbol;
  final String? leftSymbol;
  final int? precision;

  afterChange(String maskedValue, double rawValue) {
    this.selection = TextSelection.collapsed(offset: this.text.length);
  }

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this.applyMask(valueToUse);

    if (rightSymbol!.length > 0) {
      masked += rightSymbol!;
    }

    if (leftSymbol!.length > 0) {
      masked = leftSymbol! + masked;
    }

    if (masked != this.text) {
      this.text = masked;
      var cursorPosition = super.text.length - this.rightSymbol!.length;

      this.selection = new TextSelection.fromPosition(new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts = getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision!, '.');

    return double.parse(parts.join());
  }

  validateConfig() {
    bool rightSymbolHasNumbers = getOnlyNumbers(this.rightSymbol!).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String applyMask(double value) {
    List<String> textRepresentation =
        value.toStringAsFixed(precision!).replaceAll('.', '').split('').reversed.toList(growable: true);

    textRepresentation.insert(precision!, decimalSeparator!);

    for (var i = precision! + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator!);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
