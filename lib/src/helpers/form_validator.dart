import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Helpers
import 'extensions/string_extension.dart';

/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator {
  const FormValidator._();

  /// The error message for invalid name input.
  static const _invalidNameError = 'Please enter a valid name';

  /// The error message for invalid contact input.
  static const _invalidContactError = 'Please enter a valid contact';

  /// The error message for invalid identification input.
  static const _invalidIdError = 'Please enter a valid identification';

  /// A method containing validation logic for name input.
  static String? nameValidator(String? name) {
    if (name != null && name.isValidName) return null;
    return _invalidNameError;
  }

  /// A method containing validation logic for contact number input.
  static String? contactValidator(String? contact) {
    if (contact != null && contact.isValidContact) return null;
    return _invalidContactError;
  }

  /// A method containing validation logic for identification input.
  static String? idValidator(String? id) {
    if (id != null && id.isValidIdentification) return null;
    return _invalidIdError;
  }
}
