import 'package:flutter/services.dart';

class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final buffer = StringBuffer();
    for (var i = 0; i < newText.length; i++) {
      if (!newText[i].contains('/')) {
        buffer.write(newText[i]);
      }
      final nonZeroIndex = i + 1;
      if (nonZeroIndex == 2) {
        buffer.write(' / ');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
