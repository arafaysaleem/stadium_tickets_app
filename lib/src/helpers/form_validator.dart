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

  /// The error message for invalid credit card number input.
  static const _invalidCardNumberError = 'Invalid card number';

  /// The error message for invalid credit card CVV input.
  static const _invalidCardCVVError = 'Please enter a valid CVV';

  /// The error message for invalid credit card expiry input.
  static const _invalidCardExpiryError = 'Please enter a valid expiry date';

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

  /// A method containing validation logic for credit card number input.
  static String? cardNumberValidator(String? ccNumber) {
    if (ccNumber != null && ccNumber.isValidCreditCardNumber) return null;
    return _invalidCardNumberError;
  }

  /// A method containing validation logic for credit card CVV input.
  static String? cardCVVValidator(String? cvv) {
    if (cvv != null && cvv.isValidCreditCardCVV) return null;
    return _invalidCardCVVError;
  }

  /// A method containing validation logic for credit card expiry input.
  static String? cardExpiryValidator(String? expiry) {
    if (expiry != null && expiry.isValidCreditCardExpiry) return null;
    return _invalidCardExpiryError;
  }
}
