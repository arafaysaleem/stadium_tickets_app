import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Helpers
import 'extensions/string_extension.dart';

/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator {
  const FormValidator._();

  /// The error message for invalid email input.
  static const _invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const _emptyEmailInputError = 'Please enter an email';

  /// The error message for invalid name input.
  static const _invalidNameError = 'Please enter a valid name';

  /// The error message for invalid contact input.
  static const _invalidContactError = 'Please enter a valid contact';

  /// The error message for invalid identification input.
  static const _invalidIdError = 'Please enter a valid identification';

  /// A method containing validation logic for email input.
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return _emptyEmailInputError;
    } else if (!email.isValidEmail) {
      return _invalidEmailError;
    }
    return null;
  }

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
    final cardNo = ccNumber?.replaceAll(' ', '');
    if (cardNo != null && cardNo.isValidCreditCardNumber) return null;
    return 'Invalid';
  }

  /// A method containing validation logic for credit card CVV input.
  static String? cardCVVValidator(String? cvv) {
    if (cvv != null && cvv.isValidCreditCardCVV) return null;
    return 'Invalid';
  }

  /// A method containing validation logic for credit card expiry input.
  static String? cardExpiryValidator(String? expiry) {
    final expiryDate = expiry?.replaceAll(' ', '');
    if (expiryDate != null && expiryDate.isValidCreditCardExpiry) return null;
    return 'Invalid';
  }

  /// A method containing validation logic for credit card name input.
  static String? cardNameValidator(String? name) {
    if (name != null && name.isValidName) return null;
    return 'Invalid';
  }
}
